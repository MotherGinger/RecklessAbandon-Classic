local E, L, V, P, G = unpack(select(2, ...)) --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

P.general = {
    loginMessage = true,
    logLevel = LOG_LEVEL_VERBOSE,
    confirmIndividual = false,
    confirmGroup = true,
    individualQuests = {
        showAbandonButton = true,
        completeProtection = true,
        abandonBinding = "ALT-BUTTON1"
    },
    zoneQuests = {
        showAbandonButton = true,
        abandonBinding = "ALT-BUTTON1"
    }
}

P.commands = {
    generic = {
        ["*"] = false
    }
}

P.debugging = {
    debugLogging = false
}
