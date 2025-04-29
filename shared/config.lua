Config = {
    ServerCallbacks = {}, -- Don't edit or change
    EnableItemCheckOnTrigger = true, -- If true when exter-documents:showToNearbyPlayers:client is triggered, it checks whether the card item written in args is in the player.
    AddHunterLicenseToCityHall = true,
    CreateLicensesAuto = true, -- If you enable this when someone creates a char it gives idcard, driverlicense automaticly.
    CardTypes = {
        ["idcard"] = {
            command = "showidcard",
            itemControl = false,
            itemName = "idcard",
            useMetadata = true,
            usePedImage = false,
            prop = "p_ld_id_card_002"
        },
        ["driverlicense"] = {
            command = "showdriverlicense",
            itemControl = true,
            itemName = "driverlicense",
            useMetadata = true,
            usePedImage = false,
            prop = "prop_cs_swipe_card"
        },
        ["lspdbadge"] = {
            command = "showlspdbadge",
            itemControl = false,
            itemName = "lspdbadge",
            useMetadata = true,
            usePedImage = false,
            prop = "prop_cs_r_business_card"
        },
        ["lsmsbadge"] = {
            command = "showlsmsbadge",
            itemControl = false,
            itemName = "lsmsbadge",
            useMetadata = true,
            usePedImage = false,
            prop = "prop_cs_r_business_card"
        },
        ["weaponlicense"] = {
            command = "showweaponlicense",
            itemName = "weaponlicense2",
            useMetadata = true,
            prop = "prop_cs_r_business_card"
        },
        ["huntinglicense"] = {
            command = "showhuntinglicense",
            itemName = "huntinglicense",
            useMetadata = true,
            prop = "prop_cs_r_business_card"
        }
    },
    Months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"},
    LicenseAreas = {
        {
            Job = "police",
            Coords = {
                --{coords = vector3(462.15, -985.61, 30.73)}
                -- If you use target for interaction use these code lines
                {coords = vector3(450.27, -983.24, 30.69), heading = 0, scale = 2.0, width = 2.0}
            },
            Interaction = {
                Target = {
                    Enable = true,
                    Distance = 2.0,
                    Label = "Give License",
                    Icon = "fa-solid fa-address-book"
                },
                Text = {
                    Enable = false,
                    Distance = 3.0,
                    Label = "[E] Give License"
                },
                DrawText = {
                    Enable = false,
                    Distance = 3.0,
                    Show = function()
                        exports["qb-core"]:DrawText("Give License", "left")
                    end,
                    Hide = function()
                        exports["qb-core"]:HideText()
                    end
                }
            }
        }
    },
    WeaponLicenses = {
        {
            name = "Class 1",
            label = "Hitting equipments",
            weapons = {
                {name = "weapon_bat", label = "Bat", price = 150},
                {name = "weapon_poolcue", label = "Poolcue", price = 150},
                {name = "weapon_nightstick", label = "Night Stick", price = 150}
            }
        },
        {
            name = "Class 2",
            label = "Wounding strike equipments",
            weapons = {
                {name = "weapon_hammer", label = "Hammer", price = 250},
                {name = "weapon_hatchet", label = "Hatchet", price = 250},
                {name = "weapon_battleaxe", label = "Battle Axe", price = 250}
            }
        },
        {
            name = "Class 3",
            label = "Single shot guns",
            weapons = {
                {name = "weapon_gadgetpistol", label = "Gadget Pistol", price = 450},
                {name = "weapon_stungun_mp", label = "Stungun MP", price = 350},
                {name = "weapon_pistolxm3", label = "Pistol XM3", price = 450},
                {name = "weapon_ceramicpistol", label = "Ceramic Pistol", price = 450},
                {name = "weapon_doubleaction", label = "Double Action", price = 450},
                {name = "weapon_stungun", label = "Stungun", price = 250},
                {name = "weapon_flaregun", label = "Flare gun", price = 350},
                {name = "weapon_musket", label = "Musket", price = 450}
            }
        },
        {
            name = "Class 4",
            label = "Single shots & multiple shots",
            weapons = {
                {name = "weapon_pistol", label = "Pistol", price = 500},
                {name = "weapon_pistol_mk2", label = "Pistol MK2", price = 525},
                {name = "weapon_combatpistol", label = "Compat Pistol", price = 600},
                {name = "weapon_appistol", label = "AP Pistol", price = 690},
                {name = "weapon_pistol50", label = "Pistol 50", price = 635},
                {name = "weapon_snspistol", label = "SNS Pistol", price = 685},
                {name = "weapon_snspistol_mk2", label = "SNS Pistol MK2", price = 695},
                {name = "weapon_heavypistol", label = "Heavy Pistol", price = 810},
                {name = "weapon_vintagepistol", label = "Vintage Pistol", price = 775},
                {name = "weapon_marksmanpistol", label = "Marksman Pistol", price = 750},
                {name = "weapon_revolver", label = "Revolver", price = 875},
                {name = "weapon_revolver_mk2", label = "Revolver MK2", price = 890},
                {name = "weapon_navyrevolver", label = "Navy Revolver", price = 915}
            }
        },
        {
            name = "Class 5",
            label = "Light barreled",
            weapons = {
                {name = "weapon_microsmg", label = "Micro SMG", price = 1020},
                {name = "weapon_smg", label = "SMG", price = 1120},
                {name = "weapon_smg_mk2", label = "SMG MK2", price = 1180},
                {name = "weapon_assaultsmg", label = "Assault SMG", price = 1200},
                {name = "weapon_combatpdw", label = "Combat PDW", price = 1610},
                {name = "weapon_machinepistol", label = "Machine Pistol", price = 1545},
                {name = "weapon_minismg", label = "Mini SMG", price = 1560},
                {name = "weapon_tecpistol", label = "TEC Pistol", price = 950},
                {name = "weapon_raycarbine", label = "Raycarbine", price = 1750}
            }
        },
        {
            name = "Class 6",
            label = "Long barreled",
            weapons = {
                {name = "weapon_assaultrifle", label = "Assault Rifle", price = 2090},
                {name = "weapon_assaultrifle_mk2", label = "Assault Rifle MK2", price = 2150},
                {name = "weapon_carbinerifle", label = "Carbine Rifle", price = 2100},
                {name = "weapon_carbinerifle_mk2", label = "Carbine Rifle MK2", price = 2160},
                {name = "weapon_advancedrifle", label = "Advanced Rifle", price = 2200},
                {name = "weapon_specialcarbine", label = "Special Carbine", price = 2300},
                {name = "weapon_specialcarbine_mk2", label = "Special Carbine MK2", price = 2375},
                {name = "weapon_bullpuprifle", label = "Bullpup Rifle", price = 2100},
                {name = "weapon_bullpuprifle_mk2", label = "Bullpup Rifle MK2", price = 2185},
                {name = "weapon_compactrifle", label = "Compact Rifle", price = 2310},
                {name = "weapon_militaryrifle", label = "Military Rifle", price = 3100},
                {name = "weapon_heavyrifle", label = "Heavy Rifle", price = 3200},
                {name = "weapon_tacticalrifle", label = "Tactical Rifle", price = 3500}
            }
        },
        {
            name = "Class 7",
            label = "Scoped sniper weapons",
            weapons = {
                {name = "weapon_sniperrifle", label = "Sniper Rifle", price = 2650},
                {name = "weapon_heavysniper", label = "Heavy Sniper", price = 2850},
                {name = "weapon_heavysniper_mk2", label = "Heavy Sniper MK2", price = 2250},
                {name = "weapon_marksmanrifle", label = "Marksman Rifle", price = 2750},
                {name = "weapon_marksmanrifle_mk2", label = "Marksman Rifle MK2", price = 2650},
                {name = "weapon_precisionrifle", label = "Precision Rifle", price = 2450}
            }
        },
        {
            name = "Hunter License",
            label = "Hunting weapons",
            weapons = {
                {name = "weapon_sniperrifle", label = "Sniper Rifle", price = 2650},
                {name = "weapon_pumpshotgun", label = "Pump Shotgun", price = 1650}
            }
        }
    },
    CityHall = {
        Enable = true,
        MenuLabel = "CITY HALL",
        Ped = {
            coords = vector4(-554.20, -200.87, 38.22, 303.23),
            hash = "a_f_y_business_01" -- Check here for different models https://docs.fivem.net/docs/game-references/ped-models/
        },
        Blip = {
            Enable = false,
            coords = vector3(-554.20, -200.87, 38.22),
            sprite = 487,
            color = 0,
            scale = 0.5,
            text = "City Services"
        },
        Interaction = {
            Target = {
                Enable = false,
                Distance = 2.0,
                Label = "Open City Hall",
                Icon = "fa-solid fa-address-book"
            },
            Text = {
                Enable = false,
                Distance = 3.0,
                Label = "[E] Contact"
            },
            DrawText = {
                Enable = true,
                Distance = 3.0,
                Show = function()
                    exports["qb-core"]:DrawText("Contact", "E")
                end,
                Hide = function()
                    exports["qb-core"]:HideText()
                end
            }
        },
        Items = {
            {name = "idcard", label = "ID Card", price = 150},
            {name = "driverlicense", label = "Driver License", price = 200},
            {name = "lspdbadge", label = "LSPD Badge", price = 250, job = "police"},
            {name = "lsmsbadge", label = "LSMS Badge", price = 250, job = "ambulance"}
        }
    }
}