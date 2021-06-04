local E, L, V, P, G = unpack(select(2, ...)) --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

P.general = {
    loginMessage = true,
    confirmIndividual = false,
    confirmGroup = true,
    individualQuests = {
        showAbandonButton = true
    },
    zoneQuests = {
        showAbandonButton = true
    }
}

P.commands = {
    listAll = true,
    abandonAll = false,
    abandonByQuestId = false,
    excludeByQuestId = false,
    includeByQuestId = false
}

P.debugging = {
    debugLogging = false
}
