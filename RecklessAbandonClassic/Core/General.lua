local E, L, V, P, G = unpack(select(2, ...)) --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

local tostring = tostring
local format, strlen, strrep = format, strlen, strrep

E.Options.args.general = {
    type = "group",
    name = L["General"],
    order = 0,
    childGroups = "tab",
    get = function(info)
        return E.db[info[#info]]
    end,
    set = function(info, value)
        E.db[info[#info]] = value
    end,
    args = {
        general = {
            order = 0,
            type = "group",
            name = L["General"],
            args = {
                generalHeader = {
                    order = 0,
                    type = "header",
                    name = L["General Settings"]
                },
                loginMessage = {
                    order = 1,
                    type = "toggle",
                    name = L["Show login message"],
                    get = function(info)
                        return E.db.general.loginMessage
                    end,
                    set = function(info, value)
                        E.db.general.loginMessage = value
                    end
                },
                space1 = {
                    order = 2,
                    type = "description",
                    name = ""
                },
                confirmIndividual = {
                    order = 3,
                    name = L["Confirm individual abandons"],
                    desc = L["Prompt for confirmation when abandoning individual quests.\n\n|cFFFF6B6BCaution: Turning this off means a quest will be abandoned instantly. Be careful!|r"],
                    type = "toggle",
                    get = function(info)
                        return E.db.general.confirmIndividual
                    end,
                    set = function(info, value)
                        E.db.general.confirmIndividual = value
                    end
                },
                confirmGroup = {
                    order = 4,
                    name = L["Confirm group abandons"],
                    desc = L["Prompt for confirmation when abandoning multiple quests.\n\n|cFFFF6B6BCaution: Turning this off means a group of quests will be abandoned instantly. Be careful!|r"],
                    type = "toggle",
                    get = function(info)
                        return E.db.general.confirmGroup
                    end,
                    set = function(info, value)
                        E.db.general.confirmGroup = value
                    end
                },
                individualQuests = {
                    order = 5,
                    type = "group",
                    name = L["Individual Quests"],
                    inline = true,
                    args = {
                        showAbandonButton = {
                            order = 0,
                            name = L["Show Abandon Button"],
                            desc = L["Show an abandon button for individual quests."],
                            type = "toggle",
                            get = function(info)
                                return E.db.general.individualQuests.showAbandonButton
                            end,
                            set = function(info, value)
                                E.db.general.individualQuests.showAbandonButton = value
                            end
                        }
                    }
                },
                zoneQuests = {
                    order = 6,
                    type = "group",
                    name = L["Zone Quests"],
                    inline = true,
                    args = {
                        showAbandonButton = {
                            order = 0,
                            name = L["Show Group Abandon Button"],
                            desc = L["Show a group abandon button for zone quests."],
                            type = "toggle",
                            get = function(info)
                                return E.db.general.zoneQuests.showAbandonButton
                            end,
                            set = function(info, value)
                                E.db.general.zoneQuests.showAbandonButton = value
                            end
                        }
                    }
                },
                automationHeader = {
                    order = 7,
                    type = "header",
                    name = L["Automation Options"]
                },
                autoAbandonFailed = {
                    order = 8,
                    name = L["Abandon Failed Quests"],
                    desc = L["Automatically abandon failed quests."],
                    type = "toggle",
                    get = function(info)
                        return E.db.general.autoAbandonFailed
                    end,
                    set = function(info, value)
                        E.db.general.autoAbandonFailed = value
                    end
                }
            }
        },
        exclusions = {
            order = 1,
            type = "group",
            name = L["Exclusions"],
            args = {
                exclusionsHeader = {
                    order = 0,
                    type = "header",
                    name = L["Quest Exclusion List"]
                },
                exclusionDescription = {
                    order = 1,
                    type = "description",
                    width = "full",
                    name = L["The quest exclusion list allows you to exclude quests from group abandons. To use it, simply right click a quest abandon button in the quest log."] .. "\n\n"
                },
                exclusionDescription2 = {
                    order = 2,
                    type = "description",
                    width = "full",
                    name = L["|cFF00D1FFNote:|r Each character has their own exclusion list."] .. "\n\n"
                },
                excludedQuests = {
                    order = 3,
                    type = "description",
                    name = function()
                        if (E:IsEmpty(E.private.exclusions.excludedQuests)) then
                            return L["|cFF808080There are currently no quests being excluded.|r"]
                        end

                        local exclusions = format("|cFFF2E699%s|r | %s\n--------------------", L["QuestID"], L["Title"])
                        local titleFormat = "\n|cFFF2E699%s|r    | %s"
                        local orphanTitleFormat = "\n|cFFF2E699%s|r    | |cFFFF6B6B%s|r"

                        -- * Excluded quests are stored with the localized version of the title at time of exclusion
                        -- * This cannot be updated when language changes since the title can only be fetched for quests still in your log
                        -- * It would then be impossible to update titles for abandoned but still excluded quests
                        for questId, title in pairs(E.private.exclusions.excludedQuests) do
                            local orphaned = GetQuestLogIndexByID(questId) == 0
                            exclusions = exclusions .. format(orphaned and orphanTitleFormat or titleFormat, questId, title)
                        end
                        return exclusions
                    end
                },
                space1 = {
                    order = 4,
                    type = "description",
                    name = "\n"
                },
                autoPrune = {
                    order = 5,
                    type = "toggle",
                    name = L["Automatic Pruning"],
                    desc = L["Automatically prune quests from the exclusion list when they are abandoned.\n\n|cFF00D1FFNote:|r This does not retroactively prune quests that have already been abandoned, but are still in the exclusion list.\n\nUse the 'Prune Exclusion List' button below to do this manually."],
                    width = "full",
                    get = function(info)
                        return E.private.exclusions.autoPrune
                    end,
                    set = function(info, value)
                        E.private.exclusions.autoPrune = value
                    end
                },
                pruneOrphans = {
                    order = 6,
                    type = "execute",
                    name = L["Prune Exclusion List"],
                    desc = L["Quests that appear in |cFFFF6B6Bred|r are no longer detected in your quest log.\n\nYou can prune them by clicking this button, or leave them and they will be excluded again the next time they are picked up."],
                    func = function()
                        E:PruneQuestExclusions()
                    end
                },
                clearExclusions = {
                    order = 7,
                    type = "execute",
                    name = L["Clear Exclusion List"],
                    desc = L["Clear the exclusion list by including quests that are still in your quest log and pruning those that aren't."],
                    func = function()
                        E:ClearQuestExclusions()
                    end
                }
            }
        },
        commands = {
            order = 2,
            type = "group",
            name = L["Commands"],
            args = {
                commandsHeader = {
                    order = 0,
                    type = "header",
                    name = L["Slash Commands"]
                },
                listAll = {
                    order = 1,
                    name = L["Enable |cff888888/reckless list all|r"],
                    desc = L["This command lists all quests in a table."],
                    descStyle = "inline",
                    width = "full",
                    type = "toggle",
                    get = function(info)
                        return E.db.commands[info[#info]]
                    end,
                    set = function(info, value)
                        E.db.commands[info[#info]] = value
                    end
                },
                abandonAll = {
                    order = 2,
                    name = L["Enable |cff888888/reckless abandon all|r"],
                    desc = L["|cFFFFF569Warning:|r This command abandons all quests in your quest log that are not excluded from group abandons, use it wisely."],
                    descStyle = "inline",
                    width = "full",
                    type = "toggle",
                    get = function(info)
                        return E.db.commands[info[#info]]
                    end,
                    set = function(info, value)
                        E.db.commands[info[#info]] = value
                    end
                },
                abandonByQuestId = {
                    order = 3,
                    name = L["Enable |cff888888/reckless abandon <questID>|r"],
                    desc = L["This command abandons a quest that matches the provided questID."],
                    descStyle = "inline",
                    width = "full",
                    type = "toggle",
                    get = function(info)
                        return E.db.commands[info[#info]]
                    end,
                    set = function(info, value)
                        E.db.commands[info[#info]] = value
                    end
                },
                abandonByQualifier = {
                    order = 4,
                    name = L["Enable |cff888888/reckless abandon <qualifier>|r"],
                    desc = format("%s\n\n%s\n\n%s", L["This command abandons all quests that match a given qualifier and are not excluded from group abandons."], L["Available Qualifiers:"], E:Tabulate(E:GetAvailableQualifiers(), "|cFFF2E699%s|r - %s\n")),
                    descStyle = "inline",
                    width = "full",
                    type = "toggle",
                    get = function(info)
                        return E.db.commands[info[#info]]
                    end,
                    set = function(info, value)
                        E.db.commands[info[#info]] = value
                    end
                },
                excludeByQuestId = {
                    order = 5,
                    name = L["Enable |cff888888/reckless exclude <questID>|r"],
                    desc = L["This command excludes a quest that matches the provided questID from group abandons."],
                    descStyle = "inline",
                    width = "full",
                    type = "toggle",
                    get = function(info)
                        return E.db.commands[info[#info]]
                    end,
                    set = function(info, value)
                        E.db.commands[info[#info]] = value
                    end
                },
                includeByQuestId = {
                    order = 6,
                    name = L["Enable |cff888888/reckless include <questID>|r"],
                    desc = L["This command includes a quest that matches the provided questID in group abandons."],
                    descStyle = "inline",
                    width = "full",
                    type = "toggle",
                    get = function(info)
                        return E.db.commands[info[#info]]
                    end,
                    set = function(info, value)
                        E.db.commands[info[#info]] = value
                    end
                }
            }
        },
        debug = {
            order = 3,
            type = "group",
            name = L["Debugging"],
            args = {
                debuggingHeader = {
                    order = 0,
                    type = "header",
                    name = L["Debug Settings"]
                },
                debugLogging = {
                    order = 1,
                    name = L["Enable Debugging"],
                    desc = L["Print debugging statements when this is enabled.\n\n|cFF00D1FFNote:|r You can also toggle this quickly via |cff888888/reckless debug|r"],
                    type = "toggle",
                    get = function(info)
                        return E.db.debugging[info[#info]]
                    end,
                    set = function(info, value)
                        E.db.debugging[info[#info]] = value
                    end
                }
            }
        }
    }
}
