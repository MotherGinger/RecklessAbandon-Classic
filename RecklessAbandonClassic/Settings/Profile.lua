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
    },
    autoAbandonFailed = false
}

P.commands = {
    ["*"] = false
}

P.debugging = {
    debugLogging = false
}
