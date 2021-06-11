local RecklessAbandonClassic = select(2, ...)
RecklessAbandonClassic[2] = RecklessAbandonClassic[1].Libs.ACL:GetLocale("RecklessAbandonClassic", RecklessAbandonClassic[1]:GetLocale()) -- Locale doesn't exist yet, make it exist.
local E, L, V, P, G = unpack(RecklessAbandonClassic) --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

--Lua functions
local _G = _G
local tonumber, pairs, ipairs, error, unpack, select, tostring = tonumber, pairs, ipairs, error, unpack, select, tostring
local gsub, strjoin, twipe, tinsert, tremove, tContains = gsub, strjoin, wipe, tinsert, tremove, tContains
local format, find, strrep, strlen, sub = format, strfind, strrep, strlen, strsub
local assert, type, pcall, xpcall, next, print = assert, type, pcall, xpcall, next, print

--WoW API / Variables
local CreateFrame = CreateFrame
local GetCVar = GetCVar
local GetCVarBool = GetCVarBool
local GetSpellInfo = GetSpellInfo
local GetNumGroupMembers = GetNumGroupMembers
local GetNumQuestLogEntries = GetNumQuestLogEntries
local GetQuestLogTitle = GetQuestLogTitle
local GetQuestLogIndexByID = GetQuestLogIndexByID
local hooksecurefunc = hooksecurefunc
local InCombatLockdown = InCombatLockdown
local GetAddOnEnableState = GetAddOnEnableState
local IsInGroup = IsInGroup
local IsInGuild = IsInGuild
local IsInRaid = IsInRaid
local SetCVar = SetCVar
local UnitFactionGroup = UnitFactionGroup
local UnitGUID = UnitGUID
local IsAddOnLoaded = IsAddOnLoaded

local ERR_NOT_IN_COMBAT = ERR_NOT_IN_COMBAT
local LE_PARTY_CATEGORY_HOME = LE_PARTY_CATEGORY_HOME
local LE_PARTY_CATEGORY_INSTANCE = LE_PARTY_CATEGORY_INSTANCE
local C_ChatInfo_SendAddonMessage = C_ChatInfo.SendAddonMessage

--Constants
E.noop = function()
end
E.title = format("|cFF80528C%s|r |cFF00FF00%s|r", "Reckless Abandon", "BC Classic")
E.version = GetAddOnMetadata("RecklessAbandonClassic", "Version")
E.author = GetAddOnMetadata("RecklessAbandonClassic", "Author")
E.myfaction, E.myLocalizedFaction = UnitFactionGroup("player")
E.mylevel = UnitLevel("player")
E.myLocalizedClass, E.myclass, E.myClassID = UnitClass("player")
E.myLocalizedRace, E.myrace = UnitRace("player")
E.myname = UnitName("player")
E.myrealm = GetRealmName()
E.mynameRealm = format("%s - %s", E.myname, E.myrealm) -- contains spaces/dashes in realm (for profile keys)
E.wowpatch, E.wowbuild = GetBuildInfo()
E.wowbuild = tonumber(E.wowbuild)
E.isMacClient = IsMacClient()
E.isRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
E.isBCC = WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC
E.screenwidth, E.screenheight = GetPhysicalScreenSize()
E.resolution = format("%dx%d", E.screenwidth, E.screenheight)

local questGroupsByName = {}
-- TODO: We might want to create custom textures for each type
local questButtonPool = E:CreateFramePool("Button", QuestLogFrame, "RECKLESS_ABANDON_BUTTON")
local groupButtonPool = E:CreateFramePool("Button", QuestLogFrame, "RECKLESS_GROUP_ABANDON_BUTTON")

StaticPopupDialogs["RECKLESS_ABANDON_GROUP_CONFIRMATION"] = {
	text = L["Are you sure you want to abandon all quests in |cFFF2E699%s|r?\n\n|cFFFF6B6BThis cannot be undone.|r"],
	button1 = L["Yes"],
	button2 = L["No"],
	OnAccept = function(self, quests)
		E:AbandonZoneQuests(quests)
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3
}

StaticPopupDialogs["RECKLESS_ABANDON_CONFIRMATION"] = {
	text = L["Are you sure you want to abandon |cFFF2E699%s|r?\n\n|cFFFF6B6BThis cannot be undone.|r"],
	button1 = L["Yes"],
	button2 = L["No"],
	OnAccept = function(self, data)
		E:AbandonQuest(data.questId, true)
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3
}

StaticPopupDialogs["RECKLESS_ABANDON_ALL_CONFIRMATION"] = {
	text = L["Are you sure you want to abandon all of the quests in your questlog?\n\n|cFFFF6B6BThis cannot be undone.|r"],
	button1 = L["Yes"],
	button2 = L["No"],
	OnAccept = function(self, data)
		E:AbandonAllQuests()
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3
}

StaticPopupDialogs["RECKLESS_QUALIFIER_ABANDON_CONFIRMATION"] = {
	text = L["Are you sure you want to abandon the following %s quests?\n\n|cFFF2E699%s|r\n\n|cFFFF6B6BThis cannot be undone.|r"],
	button1 = L["Yes"],
	button2 = L["No"],
	OnAccept = function(self, data)
		E:AbandonQuests(data.questIds)
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3
}

local function getKey(value)
	if value ~= nil then
		return value:lower():gsub("[^a-z]", "")
	end
end

local function RenderAbandonButton(parent, offset, questId, excluded, title, tooltip)
	title = title or parent:GetText()
	tooltip = tooltip or title .. "\n\n" .. L["Left Click: Abandon quest"] .. "\n" .. (excluded and L["Right Click: Include quest in group abandons"] or L["Right Click: Exclude quest from group abandons"])

	local button = questButtonPool:Acquire()
	local texture = button:GetNormalTexture()

	button.title = title
	button.tooltip = tooltip
	button.questId = questId
	button:SetPoint("CENTER", parent, "CENTER", offset, 0)

	if excluded then
		texture:SetVertexColor(0.5, 0.5, 1, 0.7)
	else
		texture:SetVertexColor(1, 1, 1, 1)
	end

	button:SetNormalTexture(texture)
	button:Show()
end

local function RenderGroupAbandonButton(parent, offset, title, tooltip, key)
	title = title or parent:GetText()
	tooltip = tooltip or format(L["Left Click: Abandon all '%s' quests"], title)
	key = key or getKey(title)

	if questGroupsByName[key] then
		local button = groupButtonPool:Acquire()

		button.title = title
		button.tooltip = tooltip
		button.key = key
		button:SetPoint("CENTER", parent, "CENTER", offset, 0)
		button:Show()
	end
end

local function ShowAbandonButtons()
	questButtonPool:ReleaseAll()
	groupButtonPool:ReleaseAll()

	local numEntries, numQuests = GetNumQuestLogEntries()
	for i = 1, QUESTS_DISPLAYED do
		local questIndex = i + QuestLogListScrollFrame.offset
		if questIndex <= numEntries then
			local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isBounty, isStory, isHidden, isScaling = GetQuestLogTitle(questIndex)
			local questLogTitle = getglobal("QuestLogTitle" .. i)
			local questTitleTag = getglobal("QuestLogTitle" .. i .. "Tag")
			local questNumGroupMates = getglobal("QuestLogTitle" .. i .. "GroupMates")
			local questCheck = getglobal("QuestLogTitle" .. i .. "Check")
			local questNormalText = getglobal("QuestLogTitle" .. i .. "NormalText")
			local questHighlight = getglobal("QuestLogTitle" .. i .. "Highlight")

			questLogTitle:SetWidth(QuestLogListScrollFrame:GetWidth() - 50)

			if isHeader and E.db.general.zoneQuests.showAbandonButton then
				RenderGroupAbandonButton(questLogTitle, QuestLogListScrollFrame:GetWidth() - 138, title)
			elseif not isHeader and E.db.general.individualQuests.showAbandonButton then
				local excluded = E:IsExcluded(questID)
				RenderAbandonButton(questLogTitle, QuestLogListScrollFrame:GetWidth() - 163, questID, excluded, title)
			end
		end
	end
end

local function HideAbandonButtons()
	questButtonPool:ReleaseAll()
	groupButtonPool:ReleaseAll()
end

function onButtonEnter(self)
	GameTooltip:SetOwner(self)
	GameTooltip:SetText(self.tooltip)
	GameTooltip:Show()
end

function onButtonLeave(self)
	GameTooltip:Hide()
end

function onAbandonButtonClick(self, button)
	E:Debug("Click detected")
	if button == "LeftButton" then
		if E.db.general.confirmIndividual then
			local dialog = StaticPopup_Show("RECKLESS_ABANDON_CONFIRMATION", self.title)
			if dialog then
				dialog.data = {
					questId = self.questId
				}
			end
		else
			E:AbandonQuest(self.questId, true)
		end
	elseif button == "RightButton" then
		local texture = self:GetNormalTexture()
		local excluded = E:IsExcluded(self.questId)

		if excluded then
			E:IncludeQuest(self.questId)
			texture:SetVertexColor(1, 1, 1, 1)
			self.tooltip = self.title .. "\n\n" .. L["Left Click: Abandon quest"] .. "\n" .. L["Right Click: Exclude quest from group abandons"]
		else
			E:ExcludeQuest(self.questId)
			texture:SetVertexColor(0.5, 0.5, 1, 0.7)
			self.tooltip = self.title .. "\n\n" .. L["Left Click: Abandon quest"] .. "\n" .. L["Right Click: Include quest in group abandons"]
		end

		self:SetNormalTexture(texture)
	end
end

function onGroupAbandonButtonClick(self, button)
	if button == "LeftButton" then
		if E.db.general.confirmGroup then
			local dialog = StaticPopup_Show("RECKLESS_ABANDON_GROUP_CONFIRMATION", self.title)
			if dialog then
				dialog.data = self.key
			end
		else
			E:AbandonZoneQuests(self.key)
		end
	end
end

function onButtonUpdate(self)
	local buffer = 10
	local bottom = self:GetBottom()
	local top = self:GetTop()

	if bottom ~= nil and top ~= nil then
		if bottom > QuestLogListScrollFrame:GetBottom() - buffer and top < QuestLogListScrollFrame:GetTop() + buffer then
			self:Show()
		else
			self:Hide()
		end
	end
end

function E:Print(...)
	print(strjoin("", E.title, ": ", ...))
end

-- TODO Investigate having multiple debug levels
function E:Debug(...)
	if self.db.debugging.debugLogging then
		print(strjoin("", format(L["|cffffcc00%s Debug:|r"], E.title), " ", ...))
	end
end

function E:ToggleDebugging()
	self.db.debugging.debugLogging = not self.db.debugging.debugLogging
	self:Print(format(L["Debugging is now %s."], self.db.debugging.debugLogging and L["on"] or L["off"]))
end

function E:GetAvailableQualifiers()
	local qualifiers = {
		[L["failed"]] = L["Matches all failed quests."],
		-- ["daily"] = "Matches all daily quests.",
		[strlower(LFG_TYPE_DUNGEON)] = L["Matches all dungeon quests."],
		[strlower(RAID)] = L["Matches all raid quests."],
		[strlower(GROUP)] = L["Matches all group quests."],
		[strlower(ELITE)] = L["Matches all elite quests."],
		[strlower(PLAYER_DIFFICULTY2)] = L["Matches all heroic quests."],
		[strlower(PVP)] = L["Matches all pvp quests."],
		[L["green"]] = L["Matches all green quests."],
		[L["yellow"]] = L["Matches all yellow quests."],
		[L["orange"]] = L["Matches all orange quests."],
		[L["red"]] = L["Matches all red quests."],
		[L["gray"]] = L["Matches all gray quests."]
	}

	return qualifiers
end

function E:GenerateQuestTable()
	-- This generates a table of quests
	-- {
	-- 	[<zone_header_id>] = {
	-- 		["quests"] = {
	-- 			[<quest_id>] = "some-zone-header",
	-- 		} ,
	-- 		["title"] = "some-title",
	-- 		["hidden"] = false,
	-- 	},
	-- }

	local currentGroup = {quests = {}}

	for i = 1, GetNumQuestLogEntries() do
		local title, _, _, isHeader, isCollapsed, _, _, questID, _, _, _, _, _, _, _, isHidden = GetQuestLogTitle(i)
		if isHeader then
			currentGroup = {
				title = title,
				hidden = true,
				quests = {}
			}

			-- * In classic, collapsing a zone header "removes" the quests from the log since they aren't rendered
			-- * If the header is collapsed, don't overwrite the last known quests under it to work around this
			-- * This should always work as long as the headers are expanded at least once which tends to happen on initial load anyways
			if not isCollapsed then
				questGroupsByName[getKey(title)] = currentGroup
			end
		else
			currentGroup.hidden = currentGroup.hidden and isHidden
			currentGroup.quests[questID] = title
		end
	end

	self:Debug("Quest Table: " .. self:Dump(questGroupsByName))
	self:Debug("Excluded Quests: " .. self:Dump(self.private.exclusions.excludedQuests))
end

function E:AbandonAllQuests()
	for i = 1, GetNumQuestLogEntries() do
		local title, _, _, isHeader, _, _, _, questID = GetQuestLogTitle(i)

		if not isHeader then
			self:AbandonQuest(questID)
		end
	end
end

function E:AbandonZoneQuests(key)
	local group = questGroupsByName[key] or {}
	for questId, title in pairs(group.quests or {}) do
		self:AbandonQuest(questId)
	end

	if self:IsEmpty(group.quests) then
		questGroupsByName[key] = nil
	end
end

function E:AbandonQuests(questIds)
	for _, questId in ipairs(questIds) do
		self:AbandonQuest(questId)
	end
end

function E:AbandonQuest(questId, exclusionBypass)
	local logIndex = GetQuestLogIndexByID(questId)
	local title = GetQuestLogTitle(logIndex)

	if exclusionBypass or not self.private.exclusions.excludedQuests[questId] then
		SelectQuestLogEntry(logIndex)
		SetAbandonQuest()
		AbandonQuest()

		self:Print(format(L["|cFFFFFF00Abandoned quest '%s'|r"], title))

		if E.private.exclusions.autoPrune and self:IsExcluded(questId) then
			self:PruneQuestExclusion(questId)
		end
	else
		self:Print(format(L["Skipping '%s' since it is excluded from group abandons"], title))
	end
end

function E:ExcludeQuest(questId)
	local index = GetQuestLogIndexByID(questId)
	local title = GetQuestLogTitle(index)
	self:Print(format(L["Excluding quest '%s' from group abandons"], title))
	self.private.exclusions.excludedQuests[tonumber(questId)] = title
end

function E:IncludeQuest(questId)
	local index = GetQuestLogIndexByID(questId)
	local title = GetQuestLogTitle(index)
	self:Print(format(L["Including quest '%s' in group abandons"], title))
	self.private.exclusions.excludedQuests[tonumber(questId)] = nil
end

function E:IsExcluded(questId)
	return self.private.exclusions.excludedQuests[tonumber(questId)] ~= nil
end

function E:PruneQuestExclusion(questId)
	local title = E.private.exclusions.excludedQuests[tonumber(questId)]
	E.private.exclusions.excludedQuests[tonumber(questId)] = nil
	self:Print(format(L["Pruning '%s' from the exclusion list"], title))
end

function E:ClearQuestExclusions()
	for questId, _ in pairs(E.private.exclusions.excludedQuests) do
		local orphaned = GetQuestLogIndexByID(questId) == 0
		if orphaned then
			self:PruneQuestExclusion(questId)
		else
			self:IncludeQuest(questId)
		end
	end
end

function E:PruneQuestExclusions()
	local count = 0
	for questId, _ in pairs(E.private.exclusions.excludedQuests) do
		local orphaned = GetQuestLogIndexByID(questId) == 0
		if orphaned then
			count = count + 1
			self:PruneQuestExclusion(questId)
		end
	end

	self:Print(format(L["Pruned %s |4orphan:orphans;!"], count))
end

-- ! Prints twice sometimes, likely since we abandon so quickly it trigger a second event before it actually abandons
function E:AbandonFailedQuests()
	local count = 0
	for i = 1, GetNumQuestLogEntries() do
		local title, _, _, isHeader, _, isComplete, _, questID = GetQuestLogTitle(i)

		if not isHeader and isComplete == -1 then
			count = count + 1
			self:AbandonQuest(questID)
		end
	end

	if count ~= 0 then
		self:Print(format(L["Abandoned %s failed |4quest:quests;!"], count))
	end
end

----------------------------------------------------------------
----------------------- Commands -------------------------------
----------------------------------------------------------------

function E:CliListAllQuests()
	if self.db.commands.listAll then
		self:Print("-------------------------------------------")
		self:Print(L["|cFFFF9C00<Zone Header>|r"])
		self:Print(L["    |cFFF2E699<Title>|r - |cFFB5FFEB<QuestID>|r"])
		self:Print("-------------------------------------------")
		for i = 1, GetNumQuestLogEntries() do
			local title, _, _, isHeader, _, _, _, questID = GetQuestLogTitle(i)
			if isHeader then
				self:Print("|cFFFF9C00" .. title .. "|r")
			else
				self:Print("    |cFFF2E699" .. title .. "|r" .. " - " .. "|cFFB5FFEB" .. questID .. "|r")
			end
		end
	end
end

function E:CliAbandonAllQuests()
	if self.db.commands.abandonAll then
		if self.db.general.confirmGroup then
			StaticPopup_Show("RECKLESS_ABANDON_ALL_CONFIRMATION")
		else
			self:AbandonAllQuests()
		end
	else
		self:Print(L["Abandoning all quests from the command line is currently |cFFFF6B6Bdisabled|r. You can enable it in the configuration settings |cff888888/reckless config|r"])
	end
end

function E:CliAbandonQuestById(questId)
	if self.db.commands.abandonByQuestId then
		local index = GetQuestLogIndexByID(questId)
		if index ~= 0 then
			if self.db.general.confirmIndividual then
				local title = GetQuestLogTitle(index)
				local dialog = StaticPopup_Show("RECKLESS_ABANDON_CONFIRMATION", title)
				if dialog then
					dialog.data = {
						questId = questId
					}
				end
			else
				self:AbandonQuest(questId, index)
			end
		else
			self:Print(format(L["Unable to abandon quest, '%s' is not recognized. Either the quest is not in your quest log, or you may have entered the wrong id."], questId))
		end
	else
		self:Print(L["Abandoning quests from the command line is currently |cFFFF6B6Bdisabled|r. You can enable it in the configuration settings |cff888888/reckless config|r"])
	end
end

function E:CliAbandonByQualifier(qualifier)
	local qualifiers = self:GetAvailableQualifiers()

	self:Debug(format(L["Abandon invoked with qualifier '%s'"], qualifier))
	self:Debug(format(L["Available Qualifiers:%s"], self:Tabulate(qualifiers, " %s")))

	if self.db.commands.abandonByQualifier then
		if qualifier == L["failed"] then
			self:AbandonFailedQuests()
		else
			local questIds = {}
			local questTitles = {}
			for i = 1, GetNumQuestLogEntries() do
				local title, level, questTag, isHeader, _, _, _, questID = GetQuestLogTitle(i)

				if not isHeader then
					local levelDiff = level - E.mylevel
					local color
					if levelDiff >= 5 then
						color = L["red"]
					elseif levelDiff >= 3 then
						color = L["orange"]
					elseif levelDiff >= -2 then
						color = L["yellow"]
					elseif -levelDiff <= GetQuestGreenRange("player") then
						color = L["green"]
					else
						color = L["gray"]
					end

					lowerTag = questTag and strlower(questTag) or nil

					if qualifier == color or (qualifier == lowerTag and qualifiers[lowerTag] ~= nil) then
						tinsert(questIds, questID)
						tinsert(questTitles, title)
					end
				end
			end

			if #questIds > 0 then
				local dialog = StaticPopup_Show("RECKLESS_QUALIFIER_ABANDON_CONFIRMATION", qualifier, table.concat(questTitles, "\n"))
				if dialog then
					dialog.data = {
						questIds = questIds
					}
				end
			else
				self:Print(format(L["|cFF808080There are no quests that match the qualifier '%s'.|r"], qualifier))
			end
		end
	end
end

function E:CliExcludeQuestById(questId)
	if self.db.commands.excludeByQuestId then
		local index = GetQuestLogIndexByID(questId)
		local title = GetQuestLogTitle(index)
		if index ~= 0 then
			if not self:IsExcluded(questId) then
				self:ExcludeQuest(questId)
			else
				self:Print(format(L["'%s' is already excluded from group abandons!"], title))
			end
		else
			self:Print(format(L["Unable to exclude quest, '%s' is not recognized. Either the quest is not in your quest log, or you may have entered the wrong id."], questId))
		end
	else
		self:Print(L["Excluding quests from the command line is currently |cFFFF6B6Bdisabled|r. You can enable it in the configuration settings |cff888888/reckless config|r"])
	end
end

function E:CliIncludeQuestById(questId)
	if self.db.commands.includeByQuestId then
		local index = GetQuestLogIndexByID(questId)
		local title = GetQuestLogTitle(index)
		if index ~= 0 then
			if self:IsExcluded(questId) then
				self:IncludeQuest(questId)
			else
				self:Print(format(L["'%s' is already included in group abandons!"], title))
			end
		else
			self:Print(format(L["Unable to include quest, '%s' is not recognized. Either the quest is not in your quest log, or you may have entered the wrong id."], questId))
		end
	else
		self:Print(L["Including quests from the command line is currently |cFFFF6B6Bdisabled|r. You can enable it in the configuration settings |cff888888/reckless config|r"])
	end
end

function E:PrintWelcomeMessage()
	if self.db.general.loginMessage then
		self:Print(format(L["You are running |cFFB5FFEBv%s|r. Type |cff888888/reckless config|r to configure settings."], E.version))
	end
end

function E:Initialize()
	twipe(E.db)
	twipe(E.global)
	twipe(E.private)

	E.myguid = UnitGUID("player")
	E.data = E.Libs.AceDB:New("RecklessAbandonClassicDB", E.DF, true)
	E.charSettings = E.Libs.AceDB:New("RecklessAbandonClassicPrivateDB", E.privateVars)

	E.private = E.charSettings.profile
	E.db = E.data.profile
	E.global = E.data.global

	E.Options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(E.data)
	E.Options.args.profiles.order = 1

	QuestLogFrame:HookScript("OnShow", ShowAbandonButtons)
	QuestLogFrame:HookScript("OnEvent", ShowAbandonButtons)
	QuestLogFrame:HookScript("OnHide", HideAbandonButtons)

	QuestLogListScrollFrame:HookScript(
		"OnVerticalScroll",
		function()
			-- Render the next set of buttons. This is needed because the classic quest log only shows QUESTS_DISPLAYED titles at a time
			ShowAbandonButtons()

			for button in questButtonPool:EnumerateActive() do
				onButtonUpdate(button)
			end

			for button in groupButtonPool:EnumerateActive() do
				onButtonUpdate(button)
			end
		end
	)

	E.initialized = true
end
