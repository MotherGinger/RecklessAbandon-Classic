-- French localization file for esMX and esES.
local E = unpack(select(2, ...)) -- Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local L = E.Libs.ACL:NewLocale("RecklessAbandonClassic", "frFR")

if not L then
    return
end

L["Version"] = "Version"
L["Configuration"] = "Configuration"
L["Description"] = "Un outil pour abandonner rapidement (et imprudemment) des quêtes"

L["You have installed a version of this addon intended for |cFFFFFAB8%s|r, however, you are currently playing |cFFFFFAB8%s|r. You may encounter serious issues with this setup. Please install the proper version from Github, CurseForge, or WoWInterface, and restart the game."] =
    "Vous avez installé une version de cet addon destinée à |cFFFFFAB8%s|r, cependant, vous jouez actuellement à |cFFFFFAB8%s|r. Vous pourriez rencontrer des problèmes sérieux avec cette configuration. Veuillez installer la version appropriée depuis Github, CurseForge ou WoWInterface, puis redémarrer le jeu."

L["Enable"] = "Activer"
L["Enable/Disable Reckless Abandon"] = "Activer/Désactiver Reckless Abandon"

L["Yes"] = "Oui"
L["No"] = "Non"

L["|cFFFF6B6BCela ne peut pas être annulé.|r"] = "|cFFFF6B6BCela ne peut pas être annulé.|r"
L["Are you sure you want to abandon all quests in |cFFF2E699%s|r?"] = "Êtes-vous sûr de vouloir abandonner toutes les quêtes dans |cFFF2E699%s|r?"
L["Are you sure you want to abandon |cFFF2E699%s|r?"] = "Êtes-vous sûr de vouloir abandonner |cFFF2E699%s|r?"
L["Are you sure you want to abandon all of the quests in your quest log?"] = "Êtes-vous sûr de vouloir abandonner toutes les quêtes de votre journal de quêtes ?"
L["Are you sure you want to abandon the following %s quests?"] = "Êtes-vous sûr de vouloir abandonner les %s quêtes suivantes ?"

L["Only show messages for errors"] = "Afficher uniquement les messages d'erreur"
L["Only show messages for warnings and errors"] = "Afficher uniquement les messages d'avertissement et d'erreur"
L["Only show important messages"] = "Afficher uniquement les messages importants"
L["Show all messages (default)"] = "Afficher tous les messages (par défaut)"

L["Left Click: Abandon quest"] = "Clic gauche : Abandonner la quête"
L["Right Click: Exclude quest from group abandons"] = "Clic droit : Exclure la quête des abandons de groupe"
L["Right Click: Include quest in group abandons"] = "Clic droit : Inclure la quête dans les abandons de groupe"
L["Left Click: Abandon all quests"] = "Clic gauche : Abandonner toutes les quêtes"

L["|cFFFF9C00<Zone Header>|r"] = "|cFFFF9C00<En-tête de zone>|r"
L["    |cFFF2E699<Title>|r - |cFFB5FFEB<QuestID>|r"] = "    |cFFF2E699<Titre>|r - |cFFB5FFEB<IDQuête>|r"

L["General"] = "Général"
L["General Settings"] = "Paramètres généraux"
L["Debugging"] = "Débogage"
L["Commands"] = "Commandes"

L["Individual Quests"] = "Quêtes individuelles"
L["Zone Quests"] = "Quêtes de zone"
L["Keybindings"] = "Raccourcis clavier"

L["Show login message"] = "Afficher le message de connexion"
L["Messaging Rate"] = "Fréquence des messages"
L["Adjust the amount of messages you will receive from actions taken against your quest log."] = "Ajustez la quantité de messages que vous recevrez des actions effectuées sur votre journal de quêtes."
L["|cFF00D1FFNote:|r You will always be notified when a quest is abandoned on your behalf."] = "|cFF00D1FFNote :|r Vous serez toujours averti lorsqu'une quête est abandonnée en votre nom."
L["Show Abandon Button"] = "Afficher le bouton Abandonner"
L["Show Group Abandon Button"] = "Afficher le bouton d'abandon de groupe"
L["Show an abandon button for individual quests."] = "Affiche un bouton d'abandon pour les quêtes individuelles."
L["Abandon Quest"] = "Abandonner la quête"
L["Use this keybinding on a quest in your quest log to abandon it."] = "Utilisez ce raccourci sur une quête de votre journal pour l'abandonner."
L["Exclude Quest"] = "Exclure la quête"
L["Use this keybinding on a quest in your quest log to exclude it from group abandons."] = "Utilisez ce raccourci sur une quête de votre journal pour l'exclure des abandons de groupe."
L["Include Quest"] = "Inclure la quête"
L["Use this keybinding on a quest in your quest log to include it in group abandons."] = "Utilisez ce raccourci sur une quête de votre journal pour l'inclure dans les abandons de groupe."
L["Show a group abandon button for zone quests."] = "Affiche un bouton d'abandon de groupe pour les quêtes de zone."
L["Abandon Quests"] = "Abandonner les quêtes"
L["Use this keybinding on a zone header in your quest log to abandon all quests for that zone that are included in group abandons."] = "Utilisez ce raccourci sur l'en-tête de zone de votre journal pour abandonner toutes les quêtes de cette zone incluses dans les abandons de groupe."
L["Are you sure you want to bind %s?"] = "Êtes-vous sûr de vouloir lier %s ?"
L["|cFFFF6B6BCaution: This can cause you to accidentally abandon a quest when trying to select a quest in your quest log.|r"] = "|cFFFF6B6BMise en garde : Cela peut vous faire abandonner accidentellement une quête en essayant de la sélectionner dans votre journal de quêtes.|r"
L["|cFFFF6B6BCaution: This can cause you to accidentally abandon a quest when trying to track a quest in your quest log.|r"] = "|cFFFF6B6BMise en garde : Cela peut vous faire abandonner accidentellement une quête en essayant de suivre une quête dans votre journal de quêtes.|r"
L["|cFFFF6B6BCaution: This can cause you to accidentally exclude a quest from group abandons when trying to select a quest in your quest log.|r"] = "|cFFFF6B6BMise en garde : Cela peut vous faire exclure accidentellement une quête des abandons de groupe en essayant de la sélectionner dans votre journal de quêtes.|r"
L["|cFFFF6B6BCaution: This can cause you to accidentally exclude a quest from group abandons when trying to track a quest in your quest log.|r"] = "|cFFFF6B6BMise en garde : Cela peut vous faire exclure accidentellement une quête des abandons de groupe en essayant de suivre une quête dans votre journal de quêtes.|r"
L["|cFFFF6B6BCaution: This can cause you to accidentally include a quest in group abandons when trying to select a quest in your quest log.|r"] = "|cFFFF6B6BMise en garde : Cela peut vous faire inclure accidentellement une quête dans les abandons de groupe en essayant de la sélectionner dans votre journal de quêtes.|r"
L["|cFFFF6B6BCaution: This can cause you to accidentally include a quest in group abandons when trying to track a quest in your quest log.|r"] = "|cFFFF6B6BMise en garde : Cela peut vous faire inclure accidentellement une quête dans les abandons de groupe en essayant de suivre une quête dans votre journal de quêtes.|r"
L["|cFFFF6B6BCaution: This can cause you to accidentally abandon all quests in a zone when trying to expand a zone header in your quest log.|r"] = "|cFFFF6B6BMise en garde : Cela peut vous faire abandonner accidentellement toutes les quêtes d'une zone en essayant d'étendre l'en-tête de zone dans votre journal de quêtes.|r"

L["Confirm individual abandons"] = "Confirmer les abandons individuels"
L["Prompt for confirmation when abandoning individual quests."] = "Demander une confirmation lors de l'abandon de quêtes individuelles."
L["|cFFFF6B6BCaution: Turning this off means a quest will be abandoned instantly. Be careful!|r"] = "|cFFFF6B6BMise en garde : Désactiver cela signifie qu'une quête sera abandonnée instantanément. Soyez prudent !|r"
L["Confirm group abandons"] = "Confirmer les abandons de groupe"
L["Prompt for confirmation when abandoning multiple quests."] = "Demander une confirmation lors de l'abandon de plusieurs quêtes."
L["|cFFFF6B6BCaution: Turning this off means a group of quests will be abandoned instantly. Be careful!|r"] = "|cFFFF6B6BMise en garde : Désactiver cela signifie qu'un groupe de quêtes sera abandonné instantanément. Soyez prudent !|r"

L["Automation Options"] = "Options d'automatisation"
L["These options will act upon your quest log automatically. This can save you time; however, care should be taken when using them."] = "Ces options agiront automatiquement sur votre journal de quêtes. Cela peut vous faire gagner du temps, mais soyez prudent en les utilisant."
L["|cFF00D1FFNote:|r Each character has their own automation options."] = "|cFF00D1FFNote :|r Chaque personnage a ses propres options d'automatisation."
L["Abandon Quests"] = "Abandonner les quêtes"
L["Quest Type"] = "Type de quête"
L["Automatically abandon quests of the given type if they are included in group abandons."] = "Abandonner automatiquement les quêtes du type donné si elles sont incluses dans les abandons de groupe."
L["|cFFFF6B6BCaution:|r These quests will be abandoned for you; confirmation settings will be ignored."] = "|cFFFF6B6BMise en garde :|r Ces quêtes seront abandonnées pour vous ; les paramètres de confirmation seront ignorés."
L["Automatically abandoned %s |4quest:quests;!"] = "Quêtes %s abandonnées automatiquement |4:quête:quêtes;!"
L["Failed"] = "Échouées"
L["Green"] = "Vertes"
L["Yellow"] = "Jaunes"
L["Orange"] = "Oranges"
L["Red"] = "Rouges"
L["Gray"] = "Gris"
L["Quest IDs"] = "IDs de quêtes"
L["Enter quest ids separated by a comma. These quests will be abandoned automatically if they are included in group abandons."] = "Entrez les IDs de quêtes séparées par une virgule. Ces quêtes seront abandonnées automatiquement si elles sont incluses dans les abandons de groupe."

L["Slash Commands"] = "Commandes slash"
L["|cFF00D1FFNote:|r The token |cff888888reckless|r can be replaced by |cff888888rab|r for all commands."] = "|cFF00D1FFNote :|r Le jeton |cff888888reckless|r peut être remplacé par |cff888888rab|r pour toutes les commandes."
L["Enable |cff888888/reckless list all|r"] = "Activer |cff888888/reckless list all|r"
L["This command lists all quests in a table."] = "Cette commande liste toutes les quêtes dans un tableau."
L["Enable |cff888888/reckless abandon all|r"] = "Activer |cff888888/reckless abandon all|r"
L["|cFFFFF569Warning:|r This command abandons all quests in your quest log that are not excluded from group abandons; use it wisely."] = "|cFFFFF569Avertissement :|r Cette commande abandonne toutes les quêtes de votre journal qui ne sont pas exclues des abandons de groupe ; utilisez-la judicieusement."
L["Enable |cff888888/reckless abandon <questID>|r"] = "Activer |cff888888/reckless abandon <questID>|r"
L["This command abandons a quest that matches the provided questID."] = "Cette commande abandonne une quête correspondant à l'ID de quête fourni."
L["Enable |cff888888/reckless exclude <questID>|r"] = "Activer |cff888888/reckless exclude <questID>|r"
L["This command excludes a quest that matches the provided questID from group abandons."] = "Cette commande exclut une quête correspondant à l'ID de quête fourni des abandons de groupe."
L["Enable |cff888888/reckless include <questID>|r"] = "Activer |cff888888/reckless include <questID>|r"
L["This command includes a quest that matches the provided questID in group abandons."] = "Cette commande inclut une quête correspondant à l'ID de quête fourni dans les abandons de groupe."
L["Enable |cff888888/reckless abandon <qualifier>|r"] = "Activer |cff888888/reckless abandon <qualifier>|r"
L["This command abandons all quests that match a given qualifier and are not excluded from group abandons."] = "Cette commande abandonne toutes les quêtes qui correspondent à un qualificatif donné et qui ne sont pas exclues des abandons de groupe."

L["Available Qualifiers:"] = "Qualificatifs disponibles:"

L["failed"] = "échouées"
L["Matches all failed quests."] = "Correspond à toutes les quêtes échouées."
L["Matches all dungeon quests."] = "Correspond à toutes les quêtes de donjon."
L["Matches all raid quests."] = "Correspond à toutes les quêtes de raid."
L["Matches all group quests."] = "Correspond à toutes les quêtes de groupe."
L["Matches all heroic quests."] = "Correspond à toutes les quêtes héroïques."
L["Matches all elite quests."] = "Correspond à toutes les quêtes élites."
L["Matches all pvp quests."] = "Correspond à toutes les quêtes JcJ."
L["Matches all daily quests."] = "Correspond à toutes les quêtes journalières."
L["gray"] = "grises"
L["Matches all gray quests."] = "Correspond à toutes les quêtes grises."
L["green"] = "vertes"
L["Matches all green quests."] = "Correspond à toutes les quêtes vertes."
L["yellow"] = "jaunes"
L["Matches all yellow quests."] = "Correspond à toutes les quêtes jaunes."
L["orange"] = "oranges"
L["Matches all orange quests."] = "Correspond à toutes les quêtes oranges."
L["red"] = "rouges"
L["Matches all red quests."] = "Correspond à toutes les quêtes rouges."

L["Generic"] = "Générique"

L["|cffffcc00%s Debug:|r"] = "|cffffcc00%s Débogage :|r"
L["Debug Settings"] = "Paramètres de débogage"
L["Enable Debugging"] = "Activer le débogage"
L["Print debugging statements when this is enabled."] = "Affiche les déclarations de débogage lorsque cela est activé."
L["|cFF00D1FFNote:|r You can also toggle this quickly via |cff888888/reckless debug|r"] = "|cFF00D1FFNote :|r Vous pouvez également basculer rapidement via |cff888888/reckless debug|r"

L["Exclusions"] = "Exclusions"
L["Quest Exclusion List"] = "Liste d'exclusion des quêtes"
L["Prune Exclusion List"] = "Élaguer la liste d'exclusion"
L["Clear Exclusion List"] = "Effacer la liste d'exclusion"
L["The quest exclusion list allows you to exclude quests from group abandons. To use it, simply right-click a quest abandon button in the quest log."] = "La liste d'exclusion des quêtes vous permet d'exclure des quêtes des abandons de groupe. Pour l'utiliser, faites simplement un clic droit sur un bouton d'abandon de quête dans le journal de quêtes."
L["|cFF00D1FFNote:|r Each character has their own exclusion list."] = "|cFF00D1FFNote :|r Chaque personnage a sa propre liste d'exclusion."
L["Quests that appear in |cFFFF6B6Bred|r are no longer detected in your quest log."] = "Les quêtes qui apparaissent en |cFFFF6B6Brouge|r ne sont plus détectées dans votre journal de quêtes."
L["You can prune them by clicking this button, or leave them and they will be excluded again the next time they are picked up."] = "Vous pouvez les élaguer en cliquant sur ce bouton, ou les laisser et ils seront exclus à nouveau la prochaine fois qu'ils seront récupérés."
L["|cFF808080There are currently no quests being excluded.|r"] = "|cFF808080Il n'y a actuellement aucune quête exclue.|r"
L["Pruning '%s' from the exclusion list"] = "Élagage de '%s' de la liste d'exclusion"
L["Pruned %s |4orphan:orphans;!"] = "Élagué %s |4orphelin:orphelins;!"
L["Pruned %s |4orphan:orphans; from source '%s'!"] = "Élagué %s |4orphelin:orphelins; de la source '%s' !"
L["Clear the exclusion list by including quests that are still in your quest log and pruning those that aren't."] = "Effacez la liste d'exclusion en incluant les quêtes qui sont toujours dans votre journal de quêtes et en élaguant celles qui ne le sont pas."
L["Automatic Pruning"] = "Élagage automatique"
L["Automatically prune quests from the exclusion list when they are abandoned, or when they are no longer in your quest log and were excluded via automation."] = "Élaguer automatiquement les quêtes de la liste d'exclusion lorsqu'elles sont abandonnées, ou lorsqu'elles ne sont plus dans votre journal de quêtes et ont été exclues via l'automatisation."
L["|cFF00D1FFNote:|r This does not retroactively prune quests that have already been abandoned but are still in the exclusion list."] = "|cFF00D1FFNote :|r Cela n'élaguera pas rétroactivement les quêtes qui ont déjà été abandonnées mais qui figurent toujours dans la liste d'exclusion."
L["Use the 'Prune Exclusion List' button below to do this manually."] = "Utilisez le bouton 'Élaguer la liste d'exclusion' ci-dessous pour le faire manuellement."
L["Unable to prune quests from the exclusion list from source '%s'"] = "Impossible d'élaguer les quêtes de la liste d'exclusion de la source '%s'"

L["About"] = "À propos"
L["Testers"] = "Testeurs"
L["Written by |T626001:0|t |cFF3FC7EB%s|r aka |T626003:0|t |cFFF48CBAAllyïa-Mankrik (US)|r"] = "Écrit par |T626001:0|t |cFF3FC7EB%s|r alias |T626003:0|t |cFFF48CBAAllyïa-Mankrik (US)|r"
L["Please report any bugs or request features on our issue board:"] = "Veuillez signaler tout bogue ou demander des fonctionnalités sur notre tableau des problèmes :"

L["|cFFFFFF00Abandoned quest %s|r"] = "|cFFFFFF00Quête abandonnée %s|r"

L["Skipping '%s' since it is excluded from group abandons"] = "Passer '%s' car il est exclu des abandons de groupe"
L["Excluding quest '%s' from group abandons"] = "Exclure la quête '%s' des abandons de groupe"
L["Including quest '%s' in group abandons"] = "Inclure la quête '%s' dans les abandons de groupe"

L["QuestID"] = "ID de quête"
L["Title"] = "Titre"
L["Source"] = "Source"
L["Manual"] = "Manuel"
L["Automation"] = "Automatisation"

L["Abandoning all quests from the command line is currently |cFFFF6B6Bdisabled|r. You can enable it in the configuration settings |cff888888/reckless config|r"] = "Abandonner toutes les quêtes depuis la ligne de commande est actuellement |cFFFF6B6Bdésactivé|r. Vous pouvez l'activer dans les paramètres de configuration |cff888888/reckless config|r"

L["Abandoning quests from the command line is currently |cFFFF6B6Bdisabled|r. You can enable it in the configuration settings |cff888888/reckless config|r"] = "Abandonner des quêtes depuis la ligne de commande est actuellement |cFFFF6B6Bdésactivé|r. Vous pouvez l'activer dans les paramètres de configuration |cff888888/reckless config|r"
L["Unable to abandon quest, '%s' is not recognized. Either the quest is not in your quest log, or you may have entered the wrong id."] = "Impossible d'abandonner la quête, '%s' n'est pas reconnue. Soit la quête n'est pas dans votre journal de quêtes, soit vous avez peut-être saisi le mauvais ID."

L["Excluding quests from the command line is currently |cFFFF6B6Bdisabled|r. You can enable it in the configuration settings |cff888888/reckless config|r"] = "Exclure des quêtes depuis la ligne de commande est actuellement |cFFFF6B6Bdésactivé|r. Vous pouvez l'activer dans les paramètres de configuration |cff888888/reckless config|r"
L["Unable to exclude quest, '%s' is not recognized. Either the quest is not in your quest log, or you may have entered the wrong id."] = "Impossible d'exclure la quête, '%s' n'est pas reconnue. Soit la quête n'est pas dans votre journal de quêtes, soit vous avez peut-être saisi le mauvais ID."
L["%s is already excluded from group abandons!"] = "%s est déjà exclu des abandons de groupe !"

L["Including quests from the command line is currently |cFFFF6B6Bdisabled|r. You can enable it in the configuration settings |cff888888/reckless config|r"] = "Inclure des quêtes depuis la ligne de commande est actuellement |cFFFF6B6Bdésactivé|r. Vous pouvez l'activer dans les paramètres de configuration |cff888888/reckless config|r"
L["Unable to include quest, '%s' is not recognized. Either the quest is not in your quest log, or you may have entered the wrong id."] = "Impossible d'inclure la quête, '%s' n'est pas reconnue. Soit la quête n'est pas dans votre journal de quêtes, soit vous avez peut-être saisi le mauvais ID."
L["%s is alr1eady included in group abandons!"] = "%s est déjà inclus dans les abandons de groupe !"

L["You are running |cFFB5FFEBv%s|r. Type |cff888888/reckless config|r to configure settings."] = "Vous utilisez la version |cFFB5FFEBv%s|r. Tapez |cff888888/reckless config|r pour configurer les paramètres."

L["Abandon invoked with qualifier '%s'"] = "Abandon invoqué avec le qualificatif '%s'"
L["Available Qualifiers:%s"] = "Qualificatifs disponibles:%s"
L["|cFF808080There are no quests that match the qualifier '%s'.|r"] = "|cFF808080Il n'y a pas de quêtes correspondant au qualificatif '%s'.|r"

L["Debugging is now on."] = "Le débogage est maintenant activé."
L["Debugging is now off."] = "Le débogage est maintenant désactivé."
L["Auto Abandon: "] = "Abandon automatique : "
L["%s leveled up (%d -> %d)!"] = "%s a monté de niveau (%d -> %d) !"
L["Quest Table: "] = "Table des quêtes : "
L["Excluded Quests: "] = "Quêtes exclues : "

L["%s abandoned via keybinding (%s)"] = "%s abandonné via la touche de raccourci (%s)"
L["%s excluded via keybinding (%s)"] = "%s exclu via la touche de raccourci (%s)"
L["%s included via keybinding (%s)"] = "%s inclus via la touche de raccourci (%s)"
