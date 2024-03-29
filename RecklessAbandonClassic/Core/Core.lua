local RecklessAbandonClassic = select(2, ...)
RecklessAbandonClassic[2] = RecklessAbandonClassic[1].Libs.ACL:GetLocale("RecklessAbandonClassic", RecklessAbandonClassic[1]:GetLocale()) -- Locale doesn't exist yet, make it exist.
local E, L, V, P, G = unpack(RecklessAbandonClassic) --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

-- Globals
LOG_LEVEL_SYSTEM = 0
LOG_LEVEL_ERROR = 1
LOG_LEVEL_WARN = 2
LOG_LEVEL_INFO = 3
LOG_LEVEL_VERBOSE = 4
LOG_LEVEL_DEBUG = 5

MANUAL = 0
AUTOMATIC = 1

--Lua functions
local _G = _G
local tonumber, pairs, ipairs, error, unpack, select, tostring = tonumber, pairs, ipairs, error, unpack, select, tostring
local gsub, strjoin, twipe, tinsert, tremove, tContains = gsub, strjoin, wipe, tinsert, tremove, tContains
local format, find, strrep, strlen, sub = format, strfind, strrep, strlen, strsub
local assert, type, pcall, xpcall, next, print = assert, type, pcall, xpcall, next, print
local floor = floor

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
E.title = format("|cFF80528C%s|r", "Reckless Abandon")
E.subtitle = format("|cFF0080FF%s|r", "Wrath Classic")
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
E.isRetail = WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1)
E.isClassic = WOW_PROJECT_ID == (WOW_PROJECT_CLASSIC or 2)
E.isBCC = WOW_PROJECT_ID == (WOW_PROJECT_BURNING_CRUSADE_CLASSIC or 5)
E.isWrath = WOW_PROJECT_ID == (WOW_PROJECT_WRATH_CLASSIC or 11)
E.screenwidth, E.screenheight = GetPhysicalScreenSize()
E.resolution = format("%dx%d", E.screenwidth, E.screenheight)
E.wowVersionMatrix = {
	[WOW_PROJECT_MAINLINE] = "Retail",
	[WOW_PROJECT_CLASSIC] = "Classic Era",
	[WOW_PROJECT_BURNING_CRUSADE_CLASSIC] = "Burning Crusade Classic",
	[WOW_PROJECT_WRATH_CLASSIC] = "Wrath of the Lich King Classic"
}
E.logLevels = {
	[LOG_LEVEL_ERROR] = L["Only show messages for errors"],
	[LOG_LEVEL_WARN] = L["Only show messages for warnings and errors"],
	[LOG_LEVEL_INFO] = L["Only show important messages"],
	[LOG_LEVEL_VERBOSE] = L["Show all messages (default)"]
}

local abandonTooltipFormat = "|cFFFFFAB8%s|r\n\n|cFFFFF569%s|r\n|cFFB5FFEB%s|r"
local groupAbandonTooltipFormat = "|cFFFFFAB8%s|r\n\n|cFFFFF569%s|r"
local questGroupsByName = {}
-- TODO: We might want to create custom textures for each type
local questButtonPool = CreateFramePool("Button", QuestLogFrame, "RECKLESS_ABANDON_BUTTON")
local groupButtonPool = CreateFramePool("Button", QuestLogFrame, "RECKLESS_GROUP_ABANDON_BUTTON")

StaticPopupDialogs["RECKLESS_ABANDON_GROUP_CONFIRMATION"] = {
	text = table.concat(
		{
			L["Are you sure you want to abandon all quests in |cFFF2E699%s|r?"],
			L["|cFFFF6B6BThis cannot be undone.|r"]
		},
		"\n\n"
	),
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
	text = table.concat(
		{
			L["Are you sure you want to abandon |cFFF2E699%s|r?"],
			L["|cFFFF6B6BThis cannot be undone.|r"]
		},
		"\n\n"
	),
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
	text = table.concat({L["Are you sure you want to abandon all of the quests in your questlog?"], L["|cFFFF6B6BThis cannot be undone.|r"]}, "\n\n"),
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
	text = table.concat(
		{
			L["Are you sure you want to abandon the following %s quests?"],
			"|cFFF2E699%s|r",
			L["|cFFFF6B6BThis cannot be undone.|r"]
		},
		"\n\n"
	),
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

local function getKeybinding(button)
	if button == "LeftButton" then
		button = "BUTTON1"
	elseif button == "RightButton" then
		button = "BUTTON2"
	elseif button == "MiddleButton" then
		button = "BUTTON3"
	elseif button == "Button4" then
		button = "BUTTON4"
	elseif button == "Button5" then
		button = "BUTTON5"
	end

	if IsShiftKeyDown() then
		button = "SHIFT-" .. button
	end

	if IsControlKeyDown() then
		button = "CTRL-" .. button
	end

	if IsAltKeyDown() then
		button = "ALT-" .. button
	end

	return button
end

local function RenderAbandonButton(parent, offset, questId, excluded, title, tooltip)
	title = title or parent:GetText()
	tooltip = tooltip or format(abandonTooltipFormat, title, L["Left Click: Abandon quest"], (excluded and L["Right Click: Include quest in group abandons"] or L["Right Click: Exclude quest from group abandons"]))

	local button = questButtonPool:Acquire()
	local ntex = button:GetNormalTexture()
	local ptex = button:GetPushedTexture()
	local htex = button:GetHighlightTexture()

	ntex:SetTexCoord(0.25, 0.80, 0.20, 0.75)
	ptex:SetTexCoord(0.25, 0.80, 0.20, 0.75)
	htex:SetTexCoord(0.25, 0.80, 0.20, 0.75)

	button.title = title
	button.tooltip = tooltip
	button.questId = questId
	button:SetPoint("CENTER", parent, "CENTER", offset, 0)

	if excluded then
		ntex:SetVertexColor(0.5, 0.5, 1, 0.7)
	else
		ntex:SetVertexColor(1, 1, 1, 1)
	end

	button:SetNormalTexture(ntex)
	button:SetPushedTexture(ptex)
	button:SetHighlightTexture(htex)
	button:Show()
end

local function RenderGroupAbandonButton(parent, offset, title, tooltip, key)
	title = title or parent:GetText()
	tooltip = tooltip or format(groupAbandonTooltipFormat, title, L["Left Click: Abandon all quests"], title)
	key = key or getKey(title)

	if questGroupsByName[key] then
		local button = groupButtonPool:Acquire()
		local ntex = button:GetNormalTexture()
		local ptex = button:GetPushedTexture()
		local htex = button:GetHighlightTexture()

		ntex:SetTexCoord(0.25, 0.80, 0.20, 0.75)
		ptex:SetTexCoord(0.25, 0.80, 0.20, 0.75)
		htex:SetTexCoord(0.25, 0.80, 0.20, 0.75)

		button.title = title
		button.tooltip = tooltip
		button.key = key

		button:SetPoint("CENTER", parent, "CENTER", offset, 0)
		button:SetNormalTexture(ntex)
		button:SetPushedTexture(ptex)
		button:SetHighlightTexture(htex)
		button:Show()
	end
end

local function ShowAbandonButtons()
	questButtonPool:ReleaseAll()
	groupButtonPool:ReleaseAll()

	local numEntries, numQuests = GetNumQuestLogEntries()
	for i = 1, QUESTS_DISPLAYED do
		local questIndex = floor(i + QuestLogListScrollFrame.offset)
		if questIndex <= numEntries then
			local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isBounty, isStory, isHidden, isScaling = GetQuestLogTitle(questIndex)
			local questLogTitle = QuestLogListScrollFrame.buttons[i]

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

local function onQuestLogEntryClick(self, button, down)
	local abandonQuestBinding = E.db.general.individualQuests.abandonBinding
	local excludeQuestBinding = E.db.general.individualQuests.excludeBinding
	local binding = getKeybinding(button)
	local isBound = (isHeader and binding == groupAbandonQuestBinding) or binding == abandonQuestBinding or binding == excludeQuestBinding

	-- * If the click matches a binding, disable default behaviors
	-- * In retail this prevents things like the right click context menu or the full page quest description
	if self.origOnClick and not isBound then
		self:origOnClick(button, down)
	end
end

local function onQuestLogEntryMouseDown(self, button)
	local title, _, _, isHeader, _, _, _, questID = GetQuestLogTitle(self:GetID())
	local abandonQuestBinding = E.db.general.individualQuests.abandonBinding
	local excludeQuestBinding = E.db.general.individualQuests.excludeBinding
	local groupAbandonQuestBinding = E.db.general.zoneQuests.abandonBinding
	local binding = getKeybinding(button)

	if isHeader and binding == groupAbandonQuestBinding then
		if E.db.general.confirmGroup then
			local dialog = StaticPopup_Show("RECKLESS_ABANDON_GROUP_CONFIRMATION", title)
			if dialog then
				dialog.data = getKey(title)
			end
		else
			E:AbandonZoneQuests(getKey(title))
		end
		E:Debug(format(L["%s abandoned via keybinding (%s)"], title, binding))
	elseif binding == abandonQuestBinding then
		if E.db.general.confirmIndividual then
			local dialog = StaticPopup_Show("RECKLESS_ABANDON_CONFIRMATION", title)
			if dialog then
				dialog.data = {
					questId = questID
				}
			end
		else
			E:AbandonQuest(questID)
		end
		E:Debug(format(L["%s abandoned via keybinding (%s)"], title, binding))
	elseif binding == excludeQuestBinding then
		local excluded = E:IsExcluded(questID)

		if excluded then
			E:IncludeQuest(questID)
			E:Debug(format(L["%s included via keybinding (%s)"], title, binding))
		else
			E:ExcludeQuest(questID, MANUAL)
			E:Debug(format(L["%s excluded via keybinding (%s)"], title, binding))
		end

		ShowAbandonButtons()
	end

	if self.origOnMouseDown then
		self:origOnMouseDown(button)
	end
end

function onButtonEnter(self)
	GameTooltip:SetOwner(self)
	GameTooltip:SetText(self.tooltip)
	GameTooltip:SetBackdropBorderColor(255, 255, 255)
	GameTooltip:Show()
end

function onButtonLeave(self)
	GameTooltip:Hide()
end

function onAbandonButtonClick(self, button)
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
			self.tooltip = format(abandonTooltipFormat, self.title, L["Left Click: Abandon quest"], L["Right Click: Exclude quest from group abandons"])
		else
			E:ExcludeQuest(self.questId, MANUAL)
			texture:SetVertexColor(0.5, 0.5, 1, 0.7)
			self.tooltip = format(abandonTooltipFormat, self.title, L["Left Click: Abandon quest"], L["Right Click: Include quest in group abandons"])
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

function E:Print(logLevel, ...)
	if (logLevel <= E.db.general.logLevel) then
		print(strjoin("", E.title, ": ", ...))
	end
end

function E:Verbose(...)
	self:Print(LOG_LEVEL_VERBOSE, ...)
end

function E:Info(...)
	self:Print(LOG_LEVEL_INFO, ...)
end

function E:Warn(...)
	self:Print(LOG_LEVEL_WARN, ...)
end

function E:Error(...)
	self:Print(LOG_LEVEL_ERROR, ...)
end

function E:System(...)
	self:Print(LOG_LEVEL_SYSTEM, ...)
end

function E:Critical(...)
	print(strjoin("", E.title, format("|cFFFF6B6B: %s|r", ...)))
end

function E:Debug(...)
	if self.db.debugging.debugLogging then
		print(strjoin("", format(L["|cffffcc00%s Debug:|r"], E.title), " ", ...))
	end
end

function E:UpdatePlayerLevel(level)
	self:Debug(format(L["%s leveled up (%d -> %d)!"], E.myname, E.mylevel, level))
	E.mylevel = level
end

function E:GetQuestColor(level)
	local levelDiff = level - E.mylevel

	if levelDiff >= 5 then
		return L["red"]
	elseif levelDiff >= 3 then
		return L["orange"]
	elseif levelDiff >= -2 then
		return L["yellow"]
	elseif -levelDiff <= GetQuestGreenRange("player") then
		return L["green"]
	else
		return L["gray"]
	end
end

function E:GetAvailableQualifiers()
	local qualifiers = {
		[L["failed"]] = L["Matches all failed quests."],
		[strlower(LFG_TYPE_DUNGEON)] = L["Matches all dungeon quests."],
		[strlower(RAID)] = L["Matches all raid quests."],
		[strlower(GROUP)] = L["Matches all group quests."],
		[strlower(ELITE)] = L["Matches all elite quests."],
		[strlower(PLAYER_DIFFICULTY2)] = L["Matches all heroic quests."],
		[strlower(PVP)] = L["Matches all pvp quests."],
		[strlower(DAILY)] = L["Matches all daily quests."],
		[L["green"]] = L["Matches all green quests."],
		[L["yellow"]] = L["Matches all yellow quests."],
		[L["orange"]] = L["Matches all orange quests."],
		[L["red"]] = L["Matches all red quests."],
		[L["gray"]] = L["Matches all gray quests."]
	}

	local selections = {
		["failed"] = L["Failed"],
		["dungeon"] = LFG_TYPE_DUNGEON,
		["raid"] = RAID,
		["group"] = GROUP,
		["elite"] = ELITE,
		["heroic"] = PLAYER_DIFFICULTY2,
		["pvp"] = PVP,
		["daily"] = DAILY,
		["green"] = L["Green"],
		["yellow"] = L["Yellow"],
		["orange"] = L["Orange"],
		["red"] = L["Red"],
		["gray"] = L["Gray"]
	}

	return qualifiers, selections
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

	self:Debug(L["Quest Table: "] .. self:Dump(questGroupsByName))
	self:Debug(L["Excluded Quests: "] .. self:Dump(self.private.exclusions.excludedQuests))
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

		self:System(format(L["|cFFFFFF00Abandoned quest '%s'|r"], title))

		if E.private.exclusions.autoPrune and self:IsExcluded(questId) then
			self:PruneQuestExclusion(questId)
		end

		return true
	else
		self:Verbose(format(L["Skipping '%s' since it is excluded from group abandons"], title))
		return false
	end
end

function E:ExcludeQuest(questId, source)
	local index = GetQuestLogIndexByID(questId)
	local title = GetQuestLogTitle(index)
	local source = source or MANUAL
	self:Verbose(format(L["Excluding quest '%s' from group abandons"], title))
	self.private.exclusions.excludedQuests[tonumber(questId)] = {["title"] = title, ["source"] = source}

	E:RefreshGUI()
end

function E:IncludeQuest(questId)
	local index = GetQuestLogIndexByID(questId)
	local title = GetQuestLogTitle(index)
	self:Verbose(format(L["Including quest '%s' in group abandons"], title))
	self.private.exclusions.excludedQuests[tonumber(questId)] = nil

	E:RefreshGUI()
end

function E:IsExcluded(questId)
	return self.private.exclusions.excludedQuests[tonumber(questId)] ~= nil
end

function E:PruneQuestExclusion(questId)
	local title = E.private.exclusions.excludedQuests[tonumber(questId)]["title"]
	E.private.exclusions.excludedQuests[tonumber(questId)] = nil
	self:Verbose(format(L["Pruning '%s' from the exclusion list"], title))

	E:RefreshGUI()
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

function E:PruneQuestExclusionsFromAutomation()
	if E.private.exclusions.autoPrune then
		local count = 0
		for questId, meta in pairs(E.private.exclusions.excludedQuests) do
			local orphaned = GetQuestLogIndexByID(questId) == 0
			local source = meta.source
			if orphaned and source == AUTOMATIC then
				count = count + 1
				self:PruneQuestExclusion(questId)
			end
		end

		self:Debug(format(L["Pruned %s automation |4orphan:orphans;!"], count))
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

	self:Info(format(L["Pruned %s |4orphan:orphans;!"], count))
end

function E:AutoAbandonQuests()
	-- * This will abandon all quests of types that have been elected for automatic abandons
	-- * This is O(n)

	local count = 0

	for i = 1, GetNumQuestLogEntries() do
		local title, level, questTag, isHeader, _, isComplete, isDaily, questID = GetQuestLogTitle(i)

		if not isHeader then
			local levelDiff = level - E.mylevel
			local color = self:GetQuestColor(level)

			lowerTag = questTag and strlower(questTag) or nil

			local autoAbandonQuests = self.private.automationOptions.autoAbandonQuests
			local ids = autoAbandonQuests.ids or "" -- This should never be nil, but lets guard against a corrupt config

			local abandonQuestId = E:TableContainsValue({strsplit(",", ids)}, questID)
			local failed = autoAbandonQuests.questType.dungeon and strlower(LFG_TYPE_DUNGEON) == lowerTag
			local gray = autoAbandonQuests.questType.gray and L["gray"] == color
			local heroic = autoAbandonQuests.questType.heroic and strlower(PLAYER_DIFFICULTY2) == lowerTag
			local raid = autoAbandonQuests.questType.raid and strlower(RAID) == lowerTag
			local elite = autoAbandonQuests.questType.elite and strlower(ELITE) == lowerTag
			local green = autoAbandonQuests.questType.green and L["green"] == color
			local orange = autoAbandonQuests.questType.orange and L["orange"] == color
			local red = autoAbandonQuests.questType.red and L["red"] == color
			local failed = autoAbandonQuests.questType.failed and isComplete == -1
			local group = autoAbandonQuests.questType.group and strlower(GROUP) == lowerTag
			local pvp = autoAbandonQuests.questType.pvp and strlower(PVP) == lowerTag
			local daily = autoAbandonQuests.questType.daily and isDaily == 2
			local yellow = autoAbandonQuests.questType.yellow and L["yellow"] == color

			if abandonQuestId or failed or gray or heroic or raid or elite or green or orange or red or failed or group or pvp or daily or yellow then
				-- ! This triggers a second UNIT_QUEST_LOG_CHANGED event which reattempts to abandon excluded quests
				-- ! This is a bit spammy and needs to be throttled somehow
				if self:AbandonQuest(questID) then
					count = count + 1
				end
			end
		end
	end

	if count > 0 then
		self:Info(format("Automatically abandoned %s |4quest:quests;!", count))
	end
end

-- TODO: Provide an auto exclude option under automation options, and perform similar evaluations as AutoAbandonQuests
function E:AutoExcludeQuests()
	for i = 1, GetNumQuestLogEntries() do
		local _, _, _, _, _, isComplete, _, questID = GetQuestLogTitle(i)

		if not isHeader then
			if self.db.general.individualQuests.completeProtection and isComplete == 1 and not self:IsExcluded(questID) then
				self:ExcludeQuest(questID, AUTOMATIC)
			end
		end
	end
end

function E:PrintWelcomeMessage()
	if self.db.general.loginMessage then
		self:System(format(L["You are running |cFFB5FFEBv%s|r. Type |cff888888/rab|r to configure settings."], E.version))
	end

	if not E.isWrath then
		self:Critical(format(L["You have installed a version of this addon intended for |cFFFFFAB8%s|r, however you are currently playing |cFFFFFAB8%s|r. You may encounter serious issues with this setup. Please install the proper version from Github, CurseForge, or WoWInterface, and restart the game."], E.wowVersionMatrix[WOW_PROJECT_WRATH_CLASSIC or 11], E.wowVersionMatrix[WOW_PROJECT_ID]))
	end
end

function E:NormalizeSettings()
	-- * Verify default settings and guard against corrupted tables

	-- Set log level if not set
	if E.db.general.logLevel == nil then
		E.db.general.logLevel = LOG_LEVEL_VERBOSE
	end

	-- Rebuild exclusion list
	if E.private.exclusions.excludedQuests ~= nil then
		for k, v in pairs(E.private.exclusions.excludedQuests) do
			if (type(v) == "string") then
				E.private.exclusions.excludedQuests[k] = {["title"] = v, ["source"] = MANUAL}
			end
		end
	end

	-- Rebuild automation options
	if E.private.automationOptions.autoAbandonQuests.questType == nil or E:IsEmpty(E.private.automationOptions.autoAbandonQuests.questType) then
		E.private.automationOptions.autoAbandonQuests.questType = nil
		E.private.automationOptions.autoAbandonQuests = {
			["questType"] = E.private.automationOptions.autoAbandonQuests
		}
	end

	-- Rebuild command settings
	if E.db.commands.generic == nil or E:IsEmpty(E.db.commands.generic) then
		E.db.commands = {
			["generic"] = E.db.commands
		}
	end
end

function E:RegisterHotkeys()
	for i = 1, GetNumQuestLogEntries() do
		local questLogTitle = QuestLogListScrollFrame.buttons[i]

		if questLogTitle and not questLogTitle.hasOnMouseDownScript then
			questLogTitle.origOnClick = questLogTitle:GetScript("OnClick")
			questLogTitle.origOnMouseDown = questLogTitle:GetScript("OnMouseDown")

			questLogTitle:SetScript("OnClick", onQuestLogEntryClick)
			questLogTitle:SetScript("OnMouseDown", onQuestLogEntryMouseDown)

			questLogTitle.hasOnMouseDownScript = true
		end
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

	E:NormalizeSettings()

	QuestLogFrame:HookScript(
		"OnShow",
		function()
			ShowAbandonButtons()
			E:RegisterHotkeys()
		end
	)
	QuestLogFrame:HookScript(
		"OnEvent",
		function()
			ShowAbandonButtons()
			E:RegisterHotkeys()
		end
	)
	QuestLogFrame:HookScript("OnHide", HideAbandonButtons)

	QuestLogListScrollFrame.scrollBar:HookScript(
		"OnValueChanged",
		function()
			-- Render the next set of buttons. This is needed because the classic quest log only shows QUESTS_DISPLAYED titles at a time
			ShowAbandonButtons()
			E:RegisterHotkeys()

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
