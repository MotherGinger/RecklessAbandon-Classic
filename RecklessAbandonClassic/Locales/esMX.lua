-- Spanish localization file for esMX and esES.
local E = unpack(select(2, ...)) -- Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local L = E.Libs.ACL:NewLocale("RecklessAbandonClassic", "esMX")

if not L then
    return
end

L["Version"] = "Versión"
L["Configuration"] = "Configuración"
L["Description"] = "Una herramienta para abandonar misiones de forma rápida (e imprudente)"

L["Enable"] = "Habilitar"
L["Enable/Disable Reckless Abandon"] = "Habilitar / deshabilitar el Reckless Abandon"

L["Yes"] = "Sí"
L["No"] = "No"

L["Are you sure you want to abandon all quests in |cFFF2E699%s|r?\n\n|cFFFF6B6BThis cannot be undone.|r"] = "¿Estás segura de que quieres abandonar todas las misiones en |cFFF2E699%s|r?\n\n|cFFFF6B6BEsto no se puede deshacer.|r"
L["Are you sure you want to abandon |cFFF2E699%s|r?\n\n|cFFFF6B6BThis cannot be undone.|r"] = "¿Estás seguro de que quieres abandonar a |cFFF2E699%s|r?\n\n|cFFFF6B6BEsto no se puede deshacer.|r"
L["Are you sure you want to abandon all of the quests in your questlog?\n\n|cFFFF6B6BThis cannot be undone.|r"] = "¿Estás seguro de que deseas abandonar todas las misiones de tu registro de misiones?\n\n|cFFFF6B6BEsto no se puede deshacer.|r"
L["Are you sure you want to abandon the following %s quests?\n\n|cFFF2E699%s|r\n\n|cFFFF6B6BThis cannot be undone.|r"] = "¿Estás seguro de que deseas abandonar las siguientes %s misiones?\n\n|cFFF2E699%s|r\n\n|cFFFF6B6BEsto no se puede deshacer.|r"

L["Left Click: Abandon quest"] = "Clic izquierdo: Abandonar misión"
L["Right Click: Exclude quest from group abandons"] = "Clic derecho: excluir misiones de abandonos grupales"
L["Right Click: Include quest in group abandons"] = "Clic derecho: Incluir misión en abandonos grupales"
L["Left Click: Abandon all '%s' quests"] = "Clic izquierdo: abandona todas las misiones de '%s'"

L["|cFFFF9C00<Zone Header>|r"] = "|cFFFF9C00<Encabezado de zona>|r"
L["    |cFFF2E699<Title>|r - |cFFB5FFEB<QuestID>|r"] = "    |cFFF2E699<Título>|r - |cFFB5FFEB<ID de misión>|r"

L["General"] = true
L["General Settings"] = "Configuración general"
L["Debugging"] = "Depuración"
L["Commands"] = "Comandos"

L["Individual Quests"] = "Misiones individuales"
L["Zone Quests"] = "Misiones de zona"

L["Show login message"] = "Mostrar mensaje de inicio de sesión"
L["Show Abandon Button"] = "Mostrar botón de abandono"
L["Show Group Abandon Button"] = "Mostrar botón de abandono de grupo"
L["Show an abandon button for individual quests."] = "Muestra un botón de abandono para misiones individuales."
L["Show a group abandon button for zone quests."] = "Muestra un botón de abandono de grupo para misiones de zona."

L["Confirm individual abandons"] = "Confirmar abandonos individuales"
L["Prompt for confirmation when abandoning individual quests.\n\n|cFFFF6B6BCaution: Turning this off means a quest will be abandoned instantly. Be careful!|r"] = "Solicitar confirmación al abandonar misiones individuales.\n\n|cFFFF6B6BPrecaución: Desactivar esto significa que una misión se abandonará instantáneamente. ¡Ten cuidado!|r"
L["Confirm group abandons"] = "Confirmar abandonos del grupo"
L["Prompt for confirmation when abandoning multiple quests.\n\n|cFFFF6B6BCaution: Turning this off means a group of quests will be abandoned instantly. Be careful!|r"] = "Solicitar confirmación al abandonar múltiples misiones.\n\n|cFFFF6B6BPrecaución: Desactivar esto significa que un grupo de misiones se abandonará instantáneamente. ¡Ten cuidado!|r"

L["Automation Options"] = "Opciones de automatización"
L["Abandon Failed Quests"] = "Abandonar misiones fallidas"
L["Automatically abandon failed quests."] = "Abandona automáticamente las misiones fallidas."
L["Abandoned %s failed |4quest:quests;!"] = "¡Abandonó %s |4misión:misiones; fallidas!"

L["Slash Commands"] = "Comandos de barra"
L["Enable |cff888888/reckless list all|r"] = "Habilitar |cff888888/reckless list all|r"
L["This command lists all quests in a table."] = "Este comando enumera todas las misiones en una tabla."
L["Enable |cff888888/reckless abandon all|r"] = "Habilitar |cff888888/reckless abandon all|r"
L["|cFFFFF569Warning:|r This command abandons all quests in your quest log that are not excluded from group abandons, use it wisely."] = "|cFFFFF569Advertencia:|r Este comando abandona todas las misiones en su registro de misiones que no están excluidas de los abandonos grupales, utilícelo con prudencia."
L["Enable |cff888888/reckless abandon <questID>|r"] = "Habilitar |cff888888/reckless abandon <ID de misión>|r"
L["This command abandons a quest that matches the provided questID."] = "Este comando abandona una misión que coincide con el ID de misión proporcionado."
L["Enable |cff888888/reckless exclude <questID>|r"] = "Habilitar |cff888888/reckless exclude <ID de misión>|r"
L["This command excludes a quest that matches the provided questID from group abandons."] = "Este comando excluye una misión que coincide con el ID de misión proporcionado de los abandonos del grupo."
L["Enable |cff888888/reckless include <questID>|r"] = "Habilitar |cff888888/reckless include <ID de misión>|r"
L["This command includes a quest that matches the provided questID in group abandons."] = "Este comando incluye una misión que coincide con el ID de misión proporcionado en abandonos grupales."
L["Enable |cff888888/reckless abandon <qualifier>|r"] = "Habilitar |cff888888/reckless abandon <calificatorio>|r"
L["This command abandons all quests that match a given qualifier and are not excluded from group abandons."] = "Este comando abandona todas las misiones que coinciden con un calificador determinado y no se excluyen de los abandonos grupales."

L["Available Qualifiers:"] = "Calificadores disponibles:"

L["failed"] = "ha fallado"
L["Matches all failed quests."] = "Coincide con todas las misiones fallidas."
L["Matches all dungeon quests."] = "Coincide con todas las misiones de mazmorras."
L["Matches all raid quests."] = "Coincide con todas las misiones de incursión."
L["Matches all group quests."] = "Coincide con todas las misiones de grupo."
L["Matches all heroic quests."] = "Coincide con todas las misiones heroicas."
L["Matches all elite quests."] = "Coincide con todas las misiones de élite."
L["Matches all pvp quests."] = "Coincide con todas las misiones pvp."
L["gray"] = "gris"
L["Matches all gray quests."] = "Coincide con todas las misiones grises."
L["green"] = "verde"
L["Matches all green quests."] = "Coincide con todas las misiones verdes."
L["yellow"] = "amarillo"
L["Matches all yellow quests."] = "Coincide con todas las misiones amarillas."
L["orange"] = "naranja"
L["Matches all orange quests."] = "Coincide con todas las misiones naranjas."
L["red"] = "rojo"
L["Matches all red quests."] = "Coincide con todas las misiones rojas."

L["|cffffcc00%s Debug:|r"] = "|cffffcc00%s Depurar:|r"
L["Debug Settings"] = "Configuración de depuración"
L["Enable Debugging"] = "Habilitar la depuración"
L["Print debugging statements when this is enabled.\n\n|cFF00D1FFNote:|r You can also toggle this quickly via |cff888888/reckless debug|r"] = "Imprimir declaraciones de depuración cuando está habilitado.\n\n|cFF00D1FFNota:|r También puede alternar esto rápidamente a través de |cff888888/reckless debug|r"

L["Exclusions"] = "Exclusiones"
L["Quest Exclusion List"] = "Lista de exclusión de misiones"
L["Prune Exclusion List"] = "Podar lista de exclusión"
L["Clear Exclusion List"] = "Lista de exclusión clara"
L["The quest exclusion list allows you to exclude quests from group abandons. To use it, simply right click a quest abandon button in the quest log."] = "La lista de exclusión de misiones te permite excluir misiones de abandonos grupales. Para usarlo, simplemente haga clic con el botón derecho en un botón de abandono de la misión en el registro de misiones."
L["|cFF00D1FFNote:|r Each character has their own exclusion list."] = "|cFF00D1FFNota:|r Cada personaje tiene su propia lista de exclusión."
L["Quests that appear in |cFFFF6B6Bred|r are no longer detected in your quest log.\n\nYou can prune them by clicking this button, or leave them and they will be excluded again the next time they are picked up."] = "Misiones que aparecen en |cFFFF6B6Brojo|r ya no se detectan en tu registro de misiones.\n\nPuede podarlos haciendo clic en este botón, o dejarlos y serán excluidos nuevamente la próxima vez que sean recogidos."
L["|cFF808080There are currently no quests being excluded.|r"] = "|cFF808080Actualmente no se excluyen misiones.|r"
L["Pruning '%s' from the exclusion list"] = "Eliminando '%s' de la lista de exclusión"
L["Pruned %s |4orphan:orphans;!"] = "Poda %s |4huérfano:huérfanos;!"
L["Clear the exclusion list by including quests that are still in your quest log and pruning those that aren't."] = "Borre la lista de exclusión incluyendo misiones que todavía están en su registro de misiones y podando aquellas que no lo estén."
L["Automatic Pruning"] = "Poda automática"
L["Automatically prune quests from the exclusion list when they are abandoned.\n\n|cFF00D1FFNote:|r This does not retroactively prune quests that have already been abandoned, but are still in the exclusion list.\n\nUse the 'Prune Exclusion List' button below to do this manually."] =
    "Elimina automáticamente las misiones de la lista de exclusión cuando se abandonan.\n\n|cFF00D1FFNota:|r Esto no elimina de forma retroactiva las misiones que ya se han abandonado, pero que todavía están en la lista de exclusión.\n\nUse el botón 'Podar lista de exclusión' a continuación para hacer esto manualmente."

L["About"] = "Acerca de"
L["Testers"] = "Probadores"
L["Written by |T626001:0|t |cFF3FC7EB%s|r"] = "Escrito por |T626001:0|t |cFF3FC7EB%s|r"
L["Please report any bugs or request features on our issue board:"] = "Informe cualquier error o solicite funciones en nuestro tablero de problemas:"

L["|cFFFFFF00Abandoned quest %s|r"] = "|cFFFFFF00Misión abandonada %s|r"

L["Skipping %s since it is excluded from group abandons"] = "Omitiendo %s ya que está excluido de los abandonos grupales"
L["Excluding quest '%s' from group abandons"] = "Excluyendo la misión '%s' de abandonos grupales"
L["Including quest '%s' in group abandons"] = "Incluyendo la misión '%s' en abandonos grupales"

L["QuestID"] = "ID de misión"
L["Title"] = "Título"

L["Abandoning all quests from the command line is currently |cFFFF6B6Bdisabled|r. You can enable it in the configuration settings |cff888888/reckless config|r"] = "Abandonar todas las misiones desde la línea de comando está actualmente |cFFFF6B6Bdeshabilitado|r. Puede habilitarlo en los ajustes de configuración |cff888888/reckless config|r"

L["Abandoning quests from the command line is currently |cFFFF6B6Bdisabled|r. You can enable it in the configuration settings |cff888888/reckless config|r"] = "Abandonar misiones desde la línea de comando es actualmente |cFFFF6B6Bdeshabilitado|r. Puede habilitarlo en los ajustes de configuración |cff888888/reckless config|r"
L["Unable to abandon quest, '%s' is not recognized. Either the quest is not in your quest log, or you may have entered the wrong id."] = "No se puede abandonar la misión, no se reconoce '%s'. O la misión no está en tu registro de misiones o es posible que hayas ingresado la identificación incorrecta."

L["Excluding quests from the command line is currently |cFFFF6B6Bdisabled|r. You can enable it in the configuration settings |cff888888/reckless config|r"] = "La exclusión de misiones de la línea de comando es actualmente |cFFFF6B6Bdeshabilitado|r. Puede habilitarlo en los ajustes de configuración |cff888888/reckless config|r"
L["Unable to exclude quest, '%s' is not recognized. Either the quest is not in your quest log, or you may have entered the wrong id."] = "No se puede excluir la misión, '%s' no se reconoce. O la misión no está en tu registro de misiones o es posible que hayas ingresado la identificación incorrecta."
L["%s is already excluded from group abandons!"] = "¡%s ya está excluido de los abandonos grupales!"

L["Including quests from the command line is currently |cFFFF6B6Bdisabled|r. You can enable it in the configuration settings |cff888888/reckless config|r"] = "Incluir misiones desde la línea de comando es actualmente |cFFFF6B6Bdeshabilitado|r. Puede habilitarlo en los ajustes de configuración |cff888888/reckless config|r"
L["Unable to include quest, '%s' is not recognized. Either the quest is not in your quest log, or you may have entered the wrong id."] = "No se puede incluir la misión, '%s' no se reconoce. O la misión no está en tu registro de misiones o es posible que hayas ingresado la identificación incorrecta."
L["%s is alr1eady included in group abandons!"] = "¡%s ya está incluido en abandonos grupales!"

L["You are running |cFFB5FFEBv%s|r. Type |cff888888/reckless config|r to configure settings."] = "Estas corriendo |cFFB5FFEBv%s|r. Escriba |cff888888/reckless config|r para configurar los ajustes."

L["Abandon invoked with qualifier '%s'"] = "Abandono invocado con el calificador '%s'"
L["Available Qualifiers:%s"] = "Calificadores disponibles:%s"
L["|cFF808080There are no quests that match the qualifier '%s'.|r"] = "|cFF808080No hay misiones que coincidan con el clasificatorio '%s'.|r"

L["Debugging is now on."] = "La depuración está ahora activada"
L["Debugging is now off."] = "La depuración ahora está desactivada"
