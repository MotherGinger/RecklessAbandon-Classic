local E, L = unpack(select(2, ...)) --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

local _G = _G

----------------------------------------------------------------
----------------------- Commands -------------------------------
----------------------------------------------------------------

function E:CliDump(obj)
    local val = _G[obj]

    if val == nil then
        E:Info(obj)

        return
    end

    if type(val) == "table" then
        E:Info(E:Dump(val))
    else
        E:Info(val)
    end
end

function E:CliToggleDebugging()
    self.db.debugging.debugLogging = not self.db.debugging.debugLogging
    self:Info(self.db.debugging.debugLogging and L["Debugging is now on."] or L["Debugging is now off."])
end

function E:CliListAllQuests()
    if self.db.commands.generic.listAll then
        self:Info("-------------------------------------------")
        self:Info(L["|cFFFF9C00<Zone Header>|r"])
        self:Info(L["    |cFFF2E699<Title>|r - |cFFB5FFEB<QuestID>|r"])
        self:Info("-------------------------------------------")
        for i = 1, GetNumQuestLogEntries() do
            local title, _, _, isHeader, _, _, _, questID = GetQuestLogTitle(i)
            if isHeader then
                self:Info("|cFFFF9C00" .. title .. "|r")
            else
                self:Info(format("    |cFFF2E699%s|r - |cFFB5FFEB%s|r", title, questID))
            end
        end
    end
end

function E:CliAbandonAllQuests()
    if self.db.commands.generic.abandonAll then
        if self.db.general.confirmGroup then
            StaticPopup_Show("RECKLESS_ABANDON_ALL_CONFIRMATION")
        else
            self:AbandonAllQuests()
        end
    else
        self:Warn(L["Abandoning all quests from the command line is currently |cFFFF6B6Bdisabled|r. You can enable it in the configuration settings |cff888888/reckless config|r"])
    end
end

function E:CliAbandonQuestById(questId)
    if self.db.commands.generic.abandonByQuestId then
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
            self:Error(format(L["Unable to abandon quest, '%s' is not recognized. Either the quest is not in your quest log, or you may have entered the wrong id."], questId))
        end
    else
        self:Warn(L["Abandoning quests from the command line is currently |cFFFF6B6Bdisabled|r. You can enable it in the configuration settings |cff888888/reckless config|r"])
    end
end

function E:CliAbandonByQualifier(qualifier)
    local qualifiers = self:GetAvailableQualifiers()

    self:Debug(format(L["Abandon invoked with qualifier '%s'"], qualifier))
    self:Debug(format(L["Available Qualifiers:%s"], self:Tabulate(qualifiers, " %s")))

    if self.db.commands.generic.abandonByQualifier then
        local questIds = {}
        local questTitles = {}

        for i = 1, GetNumQuestLogEntries() do
            local title, level, questTag, isHeader, _, isComplete, isDaily, questID = GetQuestLogTitle(i)

            if not isHeader then
                local levelDiff = level - E.mylevel
                local color = self:GetQuestColor(level)

                lowerTag = questTag and strlower(questTag) or nil

                local isColor = qualifier == color
                local isQualifier = qualifier == lowerTag and qualifiers[lowerTag]
                local isFailed = qualifier == L["failed"] and qualifiers[L["failed"]] and isComplete == -1
                local isDaily = qualifier == strlower(DAILY) and qualifiers[strlower(DAILY)] and isDaily == 2

                if isColor or isQualifier or isFailed or isDaily then
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
            self:Error(format(L["|cFF808080There are no quests that match the qualifier '%s'.|r"], qualifier))
        end
    else
        self:Warn(L["Abandoning quests from the command line is currently |cFFFF6B6Bdisabled|r. You can enable it in the configuration settings |cff888888/reckless config|r"])
    end
end

function E:CliExcludeQuestById(questId)
    if self.db.commands.generic.excludeByQuestId then
        local index = GetQuestLogIndexByID(questId)
        local title = GetQuestLogTitle(index)
        if index ~= 0 then
            if not self:IsExcluded(questId) then
                self:ExcludeQuest(questId)
            else
                self:Warn(format(L["'%s' is already excluded from group abandons!"], title))
            end
        else
            self:Error(format(L["Unable to exclude quest, '%s' is not recognized. Either the quest is not in your quest log, or you may have entered the wrong id."], questId))
        end
    else
        self:Warn(L["Excluding quests from the command line is currently |cFFFF6B6Bdisabled|r. You can enable it in the configuration settings |cff888888/reckless config|r"])
    end
end

function E:CliIncludeQuestById(questId)
    if self.db.commands.generic.includeByQuestId then
        local index = GetQuestLogIndexByID(questId)
        local title = GetQuestLogTitle(index)
        if index ~= 0 then
            if self:IsExcluded(questId) then
                self:IncludeQuest(questId)
            else
                self:Warn(format(L["'%s' is already included in group abandons!"], title))
            end
        else
            self:Error(format(L["Unable to include quest, '%s' is not recognized. Either the quest is not in your quest log, or you may have entered the wrong id."], questId))
        end
    else
        self:Warn(L["Including quests from the command line is currently |cFFFF6B6Bdisabled|r. You can enable it in the configuration settings |cff888888/reckless config|r"])
    end
end
