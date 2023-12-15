-- Russian localization for ruRU.
local E = unpack(RecklessAbandonClassic) -- Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local L = E.Libs.ACL:NewLocale("RecklessAbandonClassic", "ruRU")

if not L then
    return
end

L["Version"] = "Версия"
L["Configuration"] = "Настройки"
L["Description"] = "Инструмент для быстрого (и безрассудного) отказа от заданий"

L["You have installed a version of this addon intended for |cFFFFFAB8%s|r, however you are currently playing |cFFFFFAB8%s|r. You may encounter serious issues with this setup. Please install the proper version from Github, CurseForge, or WoWInterface, and restart the game."] =
    "Вы установили версию этого аддона, предназначенную для |cFFFFFAB8%s|r, однако в настоящее время вы играете на |cFFFFFAB8%s|r. Возможны серьезные проблемы с этой конфигурацией. Пожалуйста, установите правильную версию с Github, CurseForge или WoWInterface и перезапустите игру."

L["Enable"] = "Включить"
L["Enable/Disable Reckless Abandon"] = "Включить/отключить безрассудное отказывание"

L["Yes"] = "Да"
L["No"] = "Нет"

L["|cFFFF6B6BThis cannot be undone.|r"] = "|cFFFF6B6BЭто действие нельзя отменить.|r"
L["Are you sure you want to abandon all quests in |cFFF2E699%s|r?"] = "Вы уверены, что хотите отказаться от всех заданий в |cFFF2E699%s|r?"
L["Are you sure you want to abandon |cFFF2E699%s|r?"] = "Вы уверены, что хотите отказаться от |cFFF2E699%s|r?"
L["Are you sure you want to abandon all of the quests in your questlog?"] = "Вы уверены, что хотите отказаться от всех заданий в вашем журнале заданий?"
L["Are you sure you want to abandon the following %s quests?"] = "Вы уверены, что хотите отказаться от следующих %s заданий?"

L["Only show messages for errors"] = "Показывать только сообщения об ошибках"
L["Only show messages for warnings and errors"] = "Показывать только предупреждения и ошибки"
L["Only show important messages"] = "Показывать только важные сообщения"
L["Show all messages (default)"] = "Показывать все сообщения (по умолчанию)"

L["Left Click: Abandon quest"] = "Левый клик: Отказаться от задания"
L["Right Click: Exclude quest from group abandons"] = "Правый клик: Исключить задание из группового отказа"
L["Right Click: Include quest in group abandons"] = "Правый клик: Включить задание в групповой отказ"
L["Left Click: Abandon all quests"] = "Левый клик: Отказаться от всех заданий"

L["|cFFFF9C00<Zone Header>|r"] = "|cFFFF9C00<Заголовок зоны>|r"
L["    |cFFF2E699<Title>|r - |cFFB5FFEB<QuestID>|r"] = "    |cFFF2E699<Название>|r - |cFFB5FFEB<ИД задания>|r"

L["General"] = "Общие"
L["General Settings"] = "Общие настройки"
L["Debugging"] = "Отладка"
L["Commands"] = "Команды"

L["Individual Quests"] = "Индивидуальные задания"
L["Zone Quests"] = "Задания в зонах"
L["Keybindings"] = "Горячие клавиши"

L["Show login message"] = "Показывать сообщение при входе"
L["Messaging Rate"] = "Частота сообщений"
L["Adjust the amount of messages you will receive from actions taken against your quest log."] = "Настройте количество сообщений, которые вы получите от действий, выполненных в вашем журнале заданий."
L["|cFF00D1FFNote:|r You will always be notified when a quest is abandoned on your behalf."] = "|cFF00D1FFПримечание:|r Вас всегда будут уведомлять, когда задание будет отказано от вашего имени."
L["Show Abandon Button"] = "Показать кнопку отказа"
L["Show Group Abandon Button"] = "Показать кнопку группового отказа"
L["Complete Protection"] = "Полная защита"
L["Automatically exclude completed quests from group abandons and automation options."] = "Автоматически исключайте завершенные задания из групповых отказов и опций автоматизации."
L["Show an abandon button for individual quests."] = "Показать кнопку отказа для отдельных заданий."
L["Abandon Quest"] = "Отказаться от задания"
L["Use this keybinding on a quest in your quest log to abandon it."] = "Используйте этот метод привязки к клавише на задании в вашем журнале, чтобы отказаться от него."
L["Exclude/Include Quest"] = "Исключить/Включить задание"
L["Use this keybinding on a quest in your quest log to toggle exclusion from group abandons."] = "Используйте это сочетание клавиш на задании в вашем журнале заданий, чтобы переключить исключение из групповых отказов."
L["Show a group abandon button for zone quests."] = "Показать кнопку группового отказа для заданий в зонах."
L["Abandon Quests"] = "Отказаться от заданий"
L["Use this keybinding on a zone header in your quest log to abandon all quests for that zone that are included in group abandons."] = "Используйте этот метод привязки к клавише на заголовке зоны в вашем журнале, чтобы отказаться от всех заданий для этой зоны, которые включены в групповой отказ."
L["Are you sure you want to bind %s?"] = "Вы уверены, что хотите назначить %s?"
L["|cFFFF6B6BCaution: This can cause you to accidentally abandon a quest when trying to select a quest in your quest log.|r"] = "|cFFFF6B6BCaution: Это может привести к случайному отказу от задания при попытке выбора задания в вашем журнале.|r"
L["|cFFFF6B6BCaution: This can cause you to accidentally abandon a quest when trying to track a quest in your quest log.|r"] = "|cFFFF6B6BCaution: Это может привести к случайному отказу от задания при попытке отслеживания задания в вашем журнале.|r"
L["|cFFFF6B6BCaution: This can cause you to accidently toggle exclusion of a quest from group abandons when trying to select a quest in your quest log.|r"] = "|cFFFF6B6BВнимание: Это может привести к случайному переключению исключения квеста из групповых отказов при попытке выбора квеста в вашем журнале заданий.|r"
L["|cFFFF6B6BCaution: This can cause you to accidently toggle exclusion of a quest from group abandons when trying to track a quest in your quest log.|r"] = "|cFFFF6B6BВнимание: Это может привести к случайному переключению исключения квеста из групповых отказов при попытке отслеживания квеста в вашем журнале заданий.|r"
L["|cFFFF6B6BCaution: This can cause you to accidentally abandon all quests in a zone when trying to expand a zone header in your quest log.|r"] = "|cFFFF6B6BCaution: Это может привести к случайному отказу от всех заданий в зоне при попытке раскрыть заголовок зоны в вашем журнале.|r"

L["Confirm individual abandons"] = "Подтверждать отказы от отдельных заданий"
L["Prompt for confirmation when abandoning individual quests."] = "Запрашивать подтверждение при отказе от отдельных заданий."
L["|cFFFF6B6BCaution: Turning this off means a quest will be abandoned instantly. Be careful!|r"] = "|cFFFF6B6BCaution: Если отключить это, задание будет отказано мгновенно. Будьте осторожны!|r"
L["Confirm group abandons"] = "Подтверждать групповые отказы"
L["Prompt for confirmation when abandoning multiple quests."] = "Запрашивать подтверждение при отказе от нескольких заданий."
L["|cFFFF6B6BCaution: Turning this off means a group of quests will be abandoned instantly. Be careful!|r"] = "|cFFFF6B6BCaution: Если отключить это, группа заданий будет отказана мгновенно. Будьте осторожны!|r"

L["Automation Options"] = "Опции автоматизации"
L["These options will act upon your quest log automatically. This can save you time, however, care should be taken when using them."] = "Эти опции будут действовать автоматически в вашем журнале заданий. Это может сэкономить вам время, однако следует быть осторожным при их использовании."
L["|cFF00D1FFNote:|r Each character has their own automation options."] = "|cFF00D1FFПримечание:|r У каждого персонажа свои опции автоматизации."
L["Abandon Quests"] = "Отказ от заданий"
L["Quest Type"] = "Тип задания"
L["Automatically abandon quests of the given type if they are included in group abandons."] = "Автоматически отказываться от заданий указанного типа, если они включены в групповые отказы."
L["|cFFFF6B6BCaution:|r These quests will be abandoned for you, confirmation settings will be ignored."] = "|cFFFF6B6BCaution:|r Эти задания будут отказаны от вашего имени, настройки подтверждения будут проигнорированы."
L["Automatically abandoned %s |4quest:quests;!"] = "Автоматически отказано от %s |4задания:заданий;!"
L["Failed"] = "Неудача"
L["Green"] = "Зеленое"
L["Yellow"] = "Желтое"
L["Orange"] = "Оранжевое"
L["Red"] = "Красное"
L["Gray"] = "Серое"
L["Quest IDs"] = "ИД заданий"
L["Enter quest ids separated by a comma. These quests will be abandoned automatically if they are included in group abandons."] = "Введите идентификаторы заданий, разделенные запятой. Эти задания будут автоматически отказаны, если они включены в групповые отказы."

L["Slash Commands"] = "Команды через слэш"
L["|cFF00D1FFNote:|r The token |cff888888reckless|r can be replaced by |cff888888rab|r for all commands."] = "|cFF00D1FFПримечание:|r Токен |cff888888reckless|r можно заменить на |cff888888rab|r для всех команд."
L["Enable |cff888888/reckless list all|r"] = "Включить |cff888888/reckless list all|r"
L["This command lists all quests in a table."] = "Эта команда выводит все задания в таблице."
L["Enable |cff888888/reckless abandon all|r"] = "Включить |cff888888/reckless abandon all|r"
L["|cFFFFF569Warning:|r This command abandons all quests in your quest log that are not excluded from group abandons, use it wisely."] = "|cFFFFF569Предупреждение:|r Эта команда отказывается от всех заданий в вашем журнале заданий, которые не исключены из групповых отказов, используйте ее разумно."
L["Enable |cff888888/reckless abandon <questID>|r"] = "Включить |cff888888/reckless abandon <questID>|r"
L["This command abandons a quest that matches the provided questID."] = "Эта команда отказывается от задания с указанным идентификатором задания."
L["Enable |cff888888/reckless exclude <questID>|r"] = "Включить |cff888888/reckless exclude <questID>|r"
L["This command excludes a quest that matches the provided questID from group abandons."] = "Эта команда исключает задание с указанным идентификатором из групповых отказов."
L["Enable |cff888888/reckless include <questID>|r"] = "Включить |cff888888/reckless include <questID>|r"
L["This command includes a quest that matches the provided questID in group abandons."] = "Эта команда включает задание с указанным идентификатором в групповые отказы."
L["Enable |cff888888/reckless abandon <qualifier>|r"] = "Включить |cff888888/reckless abandon <qualifier>|r"
L["This command abandons all quests that match a given qualifier and are not excluded from group abandons."] = "Эта команда отказывается от всех заданий, которые соответствуют заданному критерию и не исключены из групповых отказов."

L["Available Qualifiers:"] = "Доступные критерии:"

L["failed"] = "неудача"
L["Matches all failed quests."] = "Соответствует всем проваленным заданиям."
L["Matches all dungeon quests."] = "Соответствует всем заданиям в подземельях."
L["Matches all raid quests."] = "Соответствует всем заданиям рейда."
L["Matches all group quests."] = "Соответствует всем групповым заданиям."
L["Matches all heroic quests."] = "Соответствует всем героическим заданиям."
L["Matches all elite quests."] = "Соответствует всем элитным заданиям."
L["Matches all pvp quests."] = "Соответствует всем PvP-заданиям."
L["Matches all daily quests."] = "Соответствует всем ежедневным заданиям."
L["gray"] = "серый"
L["Matches all gray quests."] = "Соответствует всем серым заданиям."
L["green"] = "зеленый"
L["Matches all green quests."] = "Соответствует всем зеленым заданиям."
L["yellow"] = "желтый"
L["Matches all yellow quests."] = "Соответствует всем желтым заданиям."
L["orange"] = "оранжевый"
L["Matches all orange quests."] = "Соответствует всем оранжевым заданиям."
L["red"] = "красный"
L["Matches all red quests."] = "Соответствует всем красным заданиям."

L["Generic"] = "Общий"

L["|cffffcc00%s Debug:|r"] = "|cffffcc00Отладка %s:|r"
L["Debug Settings"] = "Настройки отладки"
L["Enable Debugging"] = "Включить отладку"
L["Print debugging statements when this is enabled."] = "Печать отладочных высказываний при включении этой опции."
L["|cFF00D1FFNote:|r You can also toggle this quickly via |cff888888/reckless debug|r"] = "|cFF00D1FFПримечание:|r Вы также можете быстро переключить это с помощью |cff888888/reckless debug|r"

L["Exclusions"] = "Исключения"
L["Quest Exclusion List"] = "Список исключений заданий"
L["Prune Exclusion List"] = "Обновить список исключений"
L["Clear Exclusion List"] = "Очистить список исключений"
L["The quest exclusion list allows you to exclude quests from group abandons. To use it, simply right click a quest abandon button in the quest log."] = "Список исключений заданий позволяет вам исключать задания из групповых отказов. Для использования просто щелкните правой кнопкой мыши на кнопке отказа от задания в журнале заданий."
L["|cFF00D1FFNote:|r Each character has their own exclusion list."] = "|cFF00D1FFПримечание:|r У каждого персонажа свой собственный список исключений."
L["Quests that appear in |cFFFF6B6Bred|r are no longer detected in your quest log."] = "Задания, отображаемые |cFFFF6B6Bкрасным|r, больше не обнаруживаются в вашем журнале заданий."
L["You can prune them by clicking this button, or leave them and they will be excluded again the next time they are picked up."] = "Вы можете обрезать их, нажав на эту кнопку, или оставить их, и они снова будут исключены, когда будут взяты."
L["|cFF808080There are currently no quests being excluded.|r"] = "|cFF808080В данный момент нет заданий, которые исключены.|r"
L["Pruning '%s' from the exclusion list"] = "Обновление '%s' в списке исключений"
L["Pruned %s |4orphan:orphans;!"] = "Обновлено %s |4сирота:сирот;! "
L["Pruned %s |4orphan:orphans; from source '%s'!"] = "Обновлено %s |4сирота:сирот;! из источника '%s'!"
L["Clear the exclusion list by including quests that are still in your quest log and pruning those that aren't."] = "Очистите список исключений, включив задания, которые все еще находятся в вашем журнале заданий, и обрезайте те, которых там нет."
L["Automatic Pruning"] = "Автоматическое обновление"
L["Automatically prune quests from the exclusion list when they are abandoned, or when they are no longer in your quest log and were excluded via automation."] = "Автоматически удалять задания из списка исключений при их отказе или когда они больше не находятся в вашем журнале заданий и были исключены автоматически."
L["|cFF00D1FFNote:|r This does not retroactively prune quests that have already been abandoned, but are still in the exclusion list."] = "|cFF00D1FFПримечание:|r Это не обновляет задания, которые уже были отказаны, но все еще находятся в списке исключений."
L["Use the 'Prune Exclusion List' button below to do this manually."] = "Используйте кнопку 'Обновить список исключений' ниже, чтобы сделать это вручную."
L["Unable to prune quests from the exclusion list from source '%s'"] = "Невозможно обновить задания из списка исключений из источника '%s'"

L["About"] = "О дополнении"
L["Testers"] = "Тестеры"
L["Written by |T626001:0|t |cFF3FC7EB%s|r aka |T626003:0|t |cFFF48CBAAllyïa-Mankrik (US)|r"] = "Написано |T626001:0|t |cFF3FC7EB%s|r, известный как |T626003:0|t |cFFF48CBAAllyïa-Mankrik (US)|r"
L["Please report any bugs or request features on our issue board:"] = "Пожалуйста, сообщайте об ошибках или предлагайте новые возможности на нашем портале проблем:"

L["|cFFFFFF00Abandoned quest %s|r"] = "|cFFFFFF00Отказ от задания %s|r"

L["Skipping '%s' since it is excluded from group abandons"] = "Пропуск '%s', так как он исключен из групповых отказов"
L["Excluding quest '%s' from group abandons"] = "Исключение задания '%s' из групповых отказов"
L["Including quest '%s' in group abandons"] = "Включение задания '%s' в групповые отказы"

L["QuestID"] = "ИД задания"
L["Title"] = "Название"
L["Source"] = "Источник"
L["Manual"] = "Вручную"
L["Automation"] = "Автоматизация"

L["Abandoning all quests from the command line is currently |cFFFF6B6Bdisabled|r. You can enable it in the configuration settings |cff888888/reckless config|r"] = "Отказ от всех заданий через командную строку в настоящее время |cFFFF6B6Bотключен|r. Вы можете включить его в настройках конфигурации |cff888888/reckless config|r"

L["Abandoning quests from the command line is currently |cFFFF6B6Bdisabled|r. You can enable it in the configuration settings |cff888888/reckless config|r"] = "Отказ от заданий через командную строку в настоящее время |cFFFF6B6Bотключен|r. Вы можете включить его в настройках конфигурации |cff888888/reckless config|r"
L["Unable to abandon quest, '%s' is not recognized. Either the quest is not in your quest log, or you may have entered the wrong id."] = "Невозможно отказаться от задания, '%s' не распознано. Либо задание отсутствует в вашем журнале заданий, либо вы можете ввести неверный идентификатор."

L["Excluding quests from the command line is currently |cFFFF6B6Bdisabled|r. You can enable it in the configuration settings |cff888888/reckless config|r"] = "Исключение заданий из командной строки в настоящее время |cFFFF6B6Bотключено|r. Вы можете включить его в настройках конфигурации |cff888888/reckless config|r"
L["Unable to exclude quest, '%s' is not recognized. Either the quest is not in your quest log, or you may have entered the wrong id."] = "Невозможно исключить задание, '%s' не распознано. Либо задание отсутствует в вашем журнале заданий, либо вы можете ввести неверный идентификатор."
L["%s is already excluded from group abandons!"] = "%s уже исключено из групповых отказов!"

L["Including quests from the command line is currently |cFFFF6B6Bdisabled|r. You can enable it in the configuration settings |cff888888/reckless config|r"] = "Включение заданий через командную строку в настоящее время |cFFFF6B6Bотключено|r. Вы можете включить его в настройках конфигурации |cff888888/reckless config|r"
L["Unable to include quest, '%s' is not recognized. Either the quest is not in your quest log, or you may have entered the wrong id."] = "Невозможно включить задание, '%s' не распознано. Либо задание отсутствует в вашем журнале заданий, либо вы можете ввести неверный идентификатор."
L["%s is already included in group abandons!"] = "%s уже включено в групповые отказы!"

L["You are running |cFFB5FFEBv%s|r. Type |cff888888/reckless config|r to configure settings."] = "Вы используете |cFFB5FFEBv%s|r. Введите |cff888888/reckless config|r для настройки параметров."

L["Abandon invoked with qualifier '%s'"] = "Отказ активирован с квалификатором '%s'"
L["Available Qualifiers:%s"] = "Доступные квалификаторы:%s"
L["|cFF808080There are no quests that match the qualifier '%s'.|r"] = "|cFF808080Нет заданий, соответствующих квалификатору '%s'.|r"

L["Debugging is now on."] = "Отладка включена."
L["Debugging is now off."] = "Отладка отключена."
L["Auto Abandon: "] = "Автоматический отказ: "
L["%s leveled up (%d -> %d)!"] = "%s повысил уровень (%d -> %d)!"
L["Quest Table: "] = "Таблица заданий: "
L["Excluded Quests: "] = "Исключенные задания: "

L["%s abandoned via keybinding (%s)"] = "%s отказано через сочетание клавиш (%s)"
L["%s excluded via keybinding (%s)"] = "%s исключено через сочетание клавиш (%s)"
L["%s included via keybinding (%s)"] = "%s включено через сочетание клавиш (%s)"