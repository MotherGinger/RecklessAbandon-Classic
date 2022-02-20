--[[
~AddOn Engine~

To load the AddOn engine add this to the top of your file:

	local E, L, V, P, G = unpack(select(2, ...)) --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

To load the AddOn engine inside another addon add this to the top of your file:

	local E, L, V, P, G = unpack(RecklessAbandonClassic) --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
]]
--Lua functions
local _G = _G
local pairs, unpack, strsplit, format, tcopy, strlower = pairs, unpack, string.split, string.format, table.copy, string.lower

--WoW API / Variables
local hooksecurefunc = hooksecurefunc
local issecurevariable = issecurevariable
local IsInInstance = IsInInstance

local CreateFrame = CreateFrame
local GetAddOnInfo = GetAddOnInfo
local GetAddOnEnableState = GetAddOnEnableState
local GetAddOnMetadata = GetAddOnMetadata
local GetLocale = GetLocale
local GetTime = GetTime
local HideUIPanel = HideUIPanel
local InCombatLockdown = InCombatLockdown
local IsAddOnLoaded = IsAddOnLoaded
local LoadAddOn = LoadAddOn
local DisableAddOn = DisableAddOn
local ReloadUI = ReloadUI

local GameMenuFrame = GameMenuFrame
local GameMenuButtonAddons = GameMenuButtonAddons
local GameMenuButtonLogout = GameMenuButtonLogout
local ERR_NOT_IN_COMBAT = ERR_NOT_IN_COMBAT
-- GLOBALS: RecklessAbandonClassicCharacterDB, RecklessAbandonClassicPrivateDB, RecklessAbandonClassicDB

local AceAddOn, AceAddonMinor = _G.LibStub("AceAddon-3.0")
local CallbackHandler = _G.LibStub("CallbackHandler-1.0")

local AddOnName, Engine = ...
local E = AceAddOn:NewAddon(AddOnName, "AceConsole-3.0", "AceEvent-3.0", "AceBucket-3.0")
E.DF = {profile = {}, global = {}} -- Defaults
E.privateVars = {profile = {}} -- Defaults
E.Options = {type = "group", args = {}}
E.callbacks = E.callbacks or CallbackHandler:New(E)
E.locale = GetLocale()

Engine[1] = E
Engine[2] = {}
Engine[3] = E.privateVars.profile
Engine[4] = E.DF.profile
Engine[5] = E.DF.global
_G.RecklessAbandonClassic = Engine

do
	local convert = {enGB = "enUS", esES = "esMX", itIT = "enUS"}
	local gameLocale = convert[E.locale] or E.locale or "enUS"

	function E:GetLocale()
		return gameLocale
	end
end

do
	E.Libs = {}
	E.LibsMinor = {}
	function E:AddLib(name, major, minor)
		if not name then
			return
		end

		-- in this case: `major` is the lib table and `minor` is the minor version
		if type(major) == "table" and type(minor) == "number" then
			self.Libs[name], self.LibsMinor[name] = major, minor
		else -- in this case: `major` is the lib name and `minor` is the silent switch
			self.Libs[name], self.LibsMinor[name] = _G.LibStub(major, minor)
		end
	end

	E:AddLib("AceAddon", AceAddon, AceAddonMinor)
	E:AddLib("AceDB", "AceDB-3.0")
	E:AddLib("ACL", "AceLocale-3.0")
	E:AddLib("AceGUI", "AceGUI-3.0")
	E:AddLib("AceConfig", "AceConfig-3.0")
	E:AddLib("AceConfigDialog", "AceConfigDialog-3.0")
	E:AddLib("AceConfigRegistry", "AceConfigRegistry-3.0")
end

function E:OnInitialize()
	if not RecklessAbandonClassicCharacterDB then
		RecklessAbandonClassicCharacterDB = {}
	end

	E.db = E:CopyTable({}, E.DF.profile)
	E.global = E:CopyTable({}, E.DF.global)
	E.private = E:CopyTable({}, E.privateVars.profile)

	if RecklessAbandonClassicDB then
		if RecklessAbandonClassicDB.global then
			E:CopyTable(E.global, RecklessAbandonClassicDB.global)
		end

		local key = RecklessAbandonClassicDB.profileKeys and RecklessAbandonClassicDB.profileKeys[E.mynameRealm]
		if key and RecklessAbandonClassicDB.profiles and RecklessAbandonClassicDB.profiles[key] then
			E:CopyTable(E.db, RecklessAbandonClassicDB.profiles[key])
		end
	end

	if RecklessAbandonClassicPrivateDB then
		local key = RecklessAbandonClassicPrivateDB.profileKeys and RecklessAbandonClassicPrivateDB.profileKeys[E.mynameRealm]
		if key and RecklessAbandonClassicPrivateDB.profiles and RecklessAbandonClassicPrivateDB.profiles[key] then
			E:CopyTable(E.private, RecklessAbandonClassicPrivateDB.profiles[key])
		end
	end

	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PLAYER_LEVEL_UP")
	self:RegisterBucketEvent("QUEST_LOG_UPDATE", 1, "QUEST_LOG_UPDATE")
	self:RegisterChatCommand("reckless", "ChatCommand")

	self.loadedtime = GetTime()
end

local LoadUI = CreateFrame("Frame")
LoadUI:RegisterEvent("QUEST_ACCEPTED")
LoadUI:RegisterEvent("QUEST_TURNED_IN")
LoadUI:RegisterEvent("QUEST_REMOVED")
LoadUI:RegisterEvent("ADDON_LOADED")
LoadUI:RegisterEvent("PLAYER_LOGIN")
LoadUI:SetScript(
	"OnEvent",
	function(Frame, event, addon)
		if event == "ADDON_LOADED" and addon == "RecklessAbandonClassic" then
			E:Initialize()
		end
	end
)

function E:ChatCommand(input)
	-- /reckless cmd args
	local _, _, cmd, args = string.find(input, "%s?(%w+)%s?(.*)")
	local qualifiers = E:GetAvailableQualifiers()

	-- TODO localize commands
	if cmd == "config" and args == "" then
		E:ToggleOptionsUI()
	elseif cmd == "list" and args == "all" then
		E:CliListAllQuests()
	elseif cmd == "abandon" and args == "all" then
		E:CliAbandonAllQuests()
	elseif cmd == "abandon" and tonumber(args) ~= nil then
		E:CliAbandonQuestById(args)
	elseif cmd == "abandon" and qualifiers[args] ~= nil then
		E:CliAbandonByQualifier(args)
	elseif cmd == "exclude" and tonumber(args) then
		E:CliExcludeQuestById(args)
	elseif cmd == "include" and tonumber(args) then
		E:CliIncludeQuestById(args)
	elseif cmd == "debug" then
		E:CliToggleDebugging()
	end

	E:RefreshGUI()
end

function E:PLAYER_ENTERING_WORLD(event, ...)
	E:PrintWelcomeMessage()
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end

function E:QUEST_LOG_UPDATE()
	E:GenerateQuestTable()

	if self.db.general.autoAbandonFailed then
		E:AbandonFailedQuests()
	end
end

function E:PLAYER_LEVEL_UP(_, arg2, ...)
	E:UpdatePlayerLevel(arg2)
end
