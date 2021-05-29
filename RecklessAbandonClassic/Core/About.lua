local E, L, V, P, G = unpack(select(2, ...)) --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

E.Options.args.about = {
    type = "group",
    name = L["About"],
    order = 2,
    childGroups = "tab",
    get = E.noop,
    set = E.noop,
    args = {
        title = {
            order = 0,
            type = "description",
            fontSize = "large",
            name = E.title
        },
        author = {
            order = 1,
            type = "description",
            fontSize = "medium",
            name = format(L["Written by |T626001:0|t |cFF3FC7EB%s|r"], E.author)
        },
        space1 = {
            order = 2,
            type = "description",
            name = "\n"
        },
        testers = {
            order = 3,
            type = "group",
            inline = true,
            name = format(L["Testers"]),
            args = {
                arrila = {
                    order = 0,
                    type = "description",
                    name = format("|T626001:0|t |cFF3FC7EB%s|r", E.author)
                },
                frauke = {
                    order = 1,
                    type = "description",
                    name = "|T626008:0|t |cFFC69B6DFrauke-Benediction (US)|r"
                },
                allyia = {
                    order = 2,
                    type = "description",
                    name = "|T626003:0|t |cFFF48CBAAllyïa-Mankrik (US)|r"
                }
            }
        },
        space2 = {
            order = 4,
            type = "description",
            name = "\n"
        },
        bugs = {
            order = 5,
            type = "input",
            name = L["Please report any bugs or request features on our issue board:"],
            width = "double",
            get = function()
                return "https://github.com/MotherGinger/RecklessAbandon-Classic/issues"
            end,
            set = E.noop
        }
    }
}
