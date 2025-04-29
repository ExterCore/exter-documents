local id = 0
local current = nil
menuActive = false
local alreadyShowing = false
RegisterNetEvent('exter-documents:showIdCard:client', function(metadata, myself)
    if metadata.firstName == nil then 
        return 
    end    
    if alreadyShowing then
        Notify(Lang:t("notify.already_showing"), 7500, "error")
    else
        id = id + 1
        metadata.id = id
        local translations = {}
        for k in pairs(Lang.fallback and Lang.fallback.phrases or Lang.phrases) do
            if k:sub(0, ('ui.'):len()) then
                translations[k:sub(('ui.'):len() + 1)] = Lang:t(k)
            end
        end
        SendNUIMessage({action = "openIdCard", metadata = metadata, id = id, translations = translations})
        local model = nil
        if current then
            DeleteEntity(prop)
            ClearPedTasks(PlayerPedId())
        end
        current = metadata.type
        local model = "p_ld_id_card_002"
        if Config.CardTypes[current] then
            model = Config.CardTypes[current].prop
        end
        if myself then
            alreadyShowing = true
            if IsPedUsingAnyScenario(PlayerPedId()) or IsPedActiveInScenario(PlayerPedId()) then
                ClearPedTasksImmediately(PlayerPedId())
            end
            RequestAnimDict("paper_1_rcm_alt1-8")
            while not HasAnimDictLoaded("paper_1_rcm_alt1-8") do
                Wait(0)
            end
            TaskPlayAnim(PlayerPedId(), "paper_1_rcm_alt1-8", "player_one_dual-8", 5.0, 5.0, -1, 51, 0, false, false, false)
            LoadModel(GetHashKey(model))
            local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
            prop = CreateObject(GetHashKey(model), x, y, z + 0.2, true, true, true)
            AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.1000, 0.0200, -0.0300, -90.000, 270.000, 78.999, true, true, false, true, 1, true)
            local closestPlayer, closestDistance = getClosestPlayer(GetEntityCoords(PlayerPedId()))
            if closestPlayer ~= -1 then
                if closestDistance <= 3.0 then
                    TriggerServerEvent('exter-documents:showIdCard:server', metadata, GetPlayerServerId(closestPlayer))
                else
                    Notify(Lang:t("notify.no_nearby_players"), 7500, "error")
                end
            end
        end
        Citizen.SetTimeout(10000, function()
            DeleteEntity(prop)
            ClearPedTasks(PlayerPedId())
            alreadyShowing = false
        end)
    end
end)

RegisterNetEvent('exter-documents:showIdCard:clientother', function(metadata, myself)
    id = id + 1
    metadata.id = id
    local translations = {}
    for k in pairs(Lang.fallback and Lang.fallback.phrases or Lang.phrases) do
        if k:sub(0, ('ui.'):len()) then
            translations[k:sub(('ui.'):len() + 1)] = Lang:t(k)
        end
    end
    SendNUIMessage({action = "openIdCard", metadata = metadata, id = id, translations = translations})
end)

function getClosestPlayer(coords)
    local ped = PlayerPedId()
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    local closestPlayers = GetPlayersFromCoords(coords)
    local closestDistance = -1
    local closestPlayer = -1
    for i = 1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() and closestPlayers[i] ~= -1 then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end

function GetPlayersFromCoords(coords, distance)
    local players = GetActivePlayers()
    local ped = PlayerPedId()
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    distance = distance or 5
    local closePlayers = {}
    for _, player in pairs(players) do
        local target = GetPlayerPed(player)
        local targetCoords = GetEntityCoords(target)
        local targetdistance = #(targetCoords - coords)
        if targetdistance <= distance then
            closePlayers[#closePlayers + 1] = player
        end
    end
    return closePlayers
end

Citizen.CreateThread(function()
    if Config.CityHall.Enable then
        local pedHash2 = type(Config.CityHall.Ped.hash) == "number" and Config.CityHall.Ped.hash or joaat(Config.CityHall.Ped.hash)
        RequestModel(pedHash2)
        while not HasModelLoaded(pedHash2) do
            Citizen.Wait(0)
        end
        Config.CityHall.Ped.ped = CreatePed(0, pedHash2, Config.CityHall.Ped.coords.x, Config.CityHall.Ped.coords.y, Config.CityHall.Ped.coords.z - 1, Config.CityHall.Ped.coords.w, false, true)
        FreezeEntityPosition(Config.CityHall.Ped.ped, true)
        SetEntityInvincible(Config.CityHall.Ped.ped, true)
        SetBlockingOfNonTemporaryEvents(Config.CityHall.Ped.ped, true)
        PlaceObjectOnGroundProperly(Config.CityHall.Ped.ped)
        SetEntityAsMissionEntity(Config.CityHall.Ped.ped, false, false)
        SetPedCanPlayAmbientAnims(Config.CityHall.Ped.ped, false) 
        SetModelAsNoLongerNeeded(pedHash2)
        if Config.CityHall.Interaction.Target.Enable then
            if GetResourceState('ox_target') == 'started' then
                exports['ox_target']:addLocalEntity(Config.CityHall.Ped.ped, {
                    [1] = {
                        label = Config.CityHall.Interaction.Target.Label,
                        icon = Config.CityHall.Interaction.Target.Icon,
                        distance = Config.CityHall.Interaction.Target.Distance,
                        onSelect = function()
                            openCityHall()
                        end
                    },
                })
            elseif GetResourceState('qb-target') == 'started' then
                exports['qb-target']:AddTargetEntity(Config.CityHall.Ped.ped, {
                    options = {
                        {
                            label = Config.CityHall.Interaction.Target.Label,
                            icon = Config.CityHall.Interaction.Target.Icon,
                            action = function()
                                openCityHall()
                            end
                        }
                    },
                    distance = Config.CityHall.Interaction.Target.Distance
                })
            end
        end
        if Config.CityHall.Blip.Enable then
            local blip = AddBlipForCoord(Config.CityHall.Blip.coords.x, Config.CityHall.Blip.coords.y, Config.CityHall.Blip.coords.z)
            SetBlipSprite(blip, Config.CityHall.Blip.sprite)
            SetBlipScale(blip, Config.CityHall.Blip.scale)
            SetBlipDisplay(blip, 4)
            SetBlipColour(blip, Config.CityHall.Blip.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Config.CityHall.Blip.text)
            EndTextCommandSetBlipName(blip)
        end
    end
end)

RegisterNetEvent('exter-documents:openCityHall:client', function()
    openCityHall()
end)

Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		local playerCoords = GetEntityCoords(PlayerPedId())
        if not menuActive then
            local dist = #(playerCoords - vector3(Config.CityHall.Ped.coords.x, Config.CityHall.Ped.coords.y, Config.CityHall.Ped.coords.z))
            if Config.CityHall.Interaction.Text.Enable then
                if dist <= Config.CityHall.Interaction.Text.Distance then
                    sleep = 0
                    ShowFloatingHelpNotification(Config.CityHall.Interaction.Text.Label, vector3(Config.CityHall.Ped.coords.x, Config.CityHall.Ped.coords.y, Config.CityHall.Ped.coords.z))
                    if IsControlJustReleased(0, 38) then
                        openCityHall()
                    end
                end
            end
        end
		Citizen.Wait(sleep)
	end
end)

function ShowFloatingHelpNotification(msg, coords)
    AddTextEntry('paIdCardFloatingHelpNotification', msg)
    SetFloatingHelpTextWorldPosition(1, coords)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('paIdCardFloatingHelpNotification')
    EndTextCommandDisplayHelp(2, false, false, -1)
end

closestPed = {}
local showTextUI = false
Citizen.CreateThread(function()
	while true do
		local sleep = 100
		if not menuActive then
			playerPed = PlayerPedId()
			playerCoords = GetEntityCoords(playerPed)
			if not closestPed.id then
                if Config.CityHall.Interaction.DrawText.Enable then
                    local dist = #(playerCoords - vector3(Config.CityHall.Ped.coords.x, Config.CityHall.Ped.coords.y, Config.CityHall.Ped.coords.z))
                    if dist <= Config.CityHall.Interaction.DrawText.Distance then
                        function currentShow()
                            Config.CityHall.Interaction.DrawText.Show()
                            showTextUI = true
                        end
                        function currentHide()
                            Config.CityHall.Interaction.DrawText.Hide()
                        end
                        closestPed = {id = 1, distance = dist, maxDist = Config.CityHall.Interaction.DrawText.Distance, data = {coords = vector3(Config.CityHall.Ped.coords.x, Config.CityHall.Ped.coords.y, Config.CityHall.Ped.coords.z)}}
                    end
                end
			end
			if closestPed.id then
				while true do
                    playerPed = PlayerPedId()
					playerCoords = GetEntityCoords(playerPed)
					closestPed.distance = #(vector3(closestPed.data.coords.x, closestPed.data.coords.y, closestPed.data.coords.z) - playerCoords)
					if closestPed.distance < closestPed.maxDist then
						if IsControlJustReleased(0, 38) then
							openCityHall()
						end
						if not showTextUI then
							currentShow()
						end
					else
						currentHide()
						break
					end
					Citizen.Wait(0)
				end
				showTextUI = false
				closestPed = {}
				sleep = 0
			end
		end
		Citizen.Wait(sleep)
	end
end)

function openCityHall()
    local playerData = GetPlayerData()
    local enableJob = nil
    local items = Config.CityHall.Items
    for k, v in pairs(items) do
        if v.job then
            if v.job == playerData.job.name then
                enableJob = playerData.job.name
            end
        end
    end
    local translations = {}
    for k in pairs(Lang.fallback and Lang.fallback.phrases or Lang.phrases) do
        if k:sub(0, ('ui.'):len()) then
            translations[k:sub(('ui.'):len() + 1)] = Lang:t(k)
        end
    end
    SendNUIMessage({action = "openCityHall", items = items, label = Config.CityHall.MenuLabel, enabledJob = enableJob, translations = translations})
    SetNuiFocus(true, true)
    menuActive = true
    local px, py, pz = table.unpack(GetEntityCoords(Config.CityHall.Ped.ped, true))
    local x, y, z = px + GetEntityForwardX(Config.CityHall.Ped.ped) * 0.9, py + GetEntityForwardY(Config.CityHall.Ped.ped) * 0.9, pz + 0.52
    local rx = GetEntityRotation(Config.CityHall.Ped.ped, 2)
    camRotation = rx + vector3(0.0, 0.0, 181.0)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", x, y, z + 0.2, camRotation, GetGameplayCamFov())
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1000, 1, 1)
    Citizen.SetTimeout(500, function()
        while menuActive and IsCamActive(cam) do
            Citizen.Wait(0)
            SetEntityLocallyInvisible(PlayerPedId())
        end
    end)
end

RegisterNUICallback('callback', function(data)
    if data.action == "nuiFocus" then
        SetNuiFocus(false, false)
        menuActive = false
        ClearFocus()
        RenderScriptCams(false, true, 1000, true, false)
        DestroyCam(cam, false)
    elseif data.action == "buy" then
        pedImage = "default"
        if Config.CardTypes[data.item].usePedImage then
            pedImage = GetMugShotBase64(PlayerPedId(), true)
        end
        TriggerServerEvent('exter-documents:buyIDCard', data.item, data.price, pedImage)
    end
end)

function LoadModel(model)
    if HasModelLoaded(model) then return end
    if not IsModelValid(model) then return print("start exter-documents-props script.") end
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end
end

RegisterNetEvent('exter-documents:createWeaponLicense:client', function()
    createWeaponLicense()
end)

function createWeaponLicense()
    local menu = {}

    table.insert(menu, {
        header = Lang:t("general.choose_weapon_class_header"),
        txt = Lang:t("general.select_type_of_weapon"),
        isMenuHeader = true -- Hanya sebagai header, tidak bisa diklik
    })

    for k, v in pairs(Config.WeaponLicenses) do
        table.insert(menu, {
            header = v.name,
            txt = v.label,
            params = {
                event = 'exter-documents:client:openCategoryMenu',
                args = {id = k, label = v.name}
            }
        })
    end

    exports['qb-menu']:openMenu(menu)
end

RegisterNetEvent('exter-documents:client:openCategoryMenu', function(data)
    openCategoryMenu(data)
end)


function openCategoryMenu(data)
    local menu = {}

    table.insert(menu, {
        header = Lang:t("general.choose_weapon_header"),
        txt = Lang:t("general.select_weapon"),
        isMenuHeader = true -- Hanya sebagai header
    })

    for k, v in pairs(Config.WeaponLicenses[data.id].weapons) do
        table.insert(menu, {
            header = v.label .. " | $" .. v.price,
            txt = v.name,
            params = {
                event = 'exter-documents:client:openChooseTypeMenu',
                args = {
                    classLabel = data.label,
                    weaponName = v.name,
                    weaponLabel = v.label,
                    weaponPrice = v.price,
                    id = k
                }
            }
        })
    end

    exports['qb-menu']:openMenu(menu)
end

RegisterNetEvent('exter-documents:client:openChooseTypeMenu', function(data)
    openChooseTypeMenu(data)
end)


function openChooseTypeMenu(data)
    local menu = {
        {
            header = Lang:t("general.choose_license_type_header"),
            txt = Lang:t("general.choose_license_type_description"),
            isMenuHeader = true
        },
        {
            header = Lang:t("general.license_type_default"),
            params = {
                event = 'exter-documents:client:openChoosePlayerMenu',
                args = {
                    classLabel = data.classLabel,
                    weaponName = data.weaponName,
                    weaponLabel = data.weaponLabel,
                    weaponPrice = data.weaponPrice,
                    id = data.id,
                    licenseType = "Weapon"
                }
            }
        },
        {
            header = Lang:t("general.license_type_hunting"),
            params = {
                event = 'exter-documents:client:openChoosePlayerMenu',
                args = {
                    classLabel = data.classLabel,
                    weaponName = data.weaponName,
                    weaponLabel = data.weaponLabel,
                    weaponPrice = data.weaponPrice,
                    id = data.id,
                    licenseType = "Hunting"
                }
            }
        }
    }

    exports['qb-menu']:openMenu(menu)
end

RegisterNetEvent('exter-documents:client:openChoosePlayerMenu', function(data)
    openChoosePlayerMenu(data)
end)


function openChoosePlayerMenu(data)
    local menu = {}
    local nearbyPlayers = GetPlayersInArea(GetEntityCoords(PlayerPedId()), 5.0)

    if next(nearbyPlayers) then
        TriggerCallback('exter-documents:getNearbyPlayerDatas:server', function(nearbyPlayers2)
            table.insert(menu, {
                header = Lang:t("general.class_label_header", {
                    class = data.classLabel,
                    license_type = data.licenseType
                }),
                txt = Lang:t("general.choose_player", {
                    class = string.lower(data.classLabel),
                    label = string.lower(data.weaponLabel),
                    price = data.weaponPrice
                }),
                isMenuHeader = true
            })

            for _, v in pairs(nearbyPlayers2) do
                table.insert(menu, {
                    header = v.name,
                    txt = "ID: " .. v.id,
                    params = {
                        event = 'exter-documents:client:openConfirmMenu',
                        args = {
                            id = v.id,
                            cid = v.cid,
                            name = v.name,
                            weaponClass = data.classLabel,
                            weaponName = data.weaponLabel,
                            price = data.weaponPrice,
                            type = data.licenseType
                        }
                    }
                })
            end

            exports["qb-menu"]:openMenu(menu)
        end, nearbyPlayers)
    else
        Notify(Lang:t("notify.no_nearby_players"), 7500, "error")
    end
end

RegisterNetEvent('exter-documents:client:openConfirmMenu', function(data)
    openConfirmMenu(data)
end)


function openConfirmMenu(data)
    local menu = {
        {
            header = Lang:t("general.class_label2_header"),
            txt = Lang:t("general.confirm_create_license", { name = string.upper(data.name) }),
            isMenuHeader = true
        },
        {
            header = Lang:t("general.confirm"),
            icon = "fas fa-check",
            params = {
                isServer = true,
                event = "exter-documents:createWeaponLicense:server",
                args = {
                    cid = data.cid, 
                    targetId = data.id,
                    className = data.weaponClass,
                    weaponName = data.weaponName,
                    price = data.price,
                    type = data.type
                }
            }
        },
        {
            header = Lang:t("general.decline"),
            icon = "fas fa-times",
            params = {
                event = "qb-menu:client:closeMenu"
            }
        }
    }

    exports["qb-menu"]:openMenu(menu)
end


RegisterNetEvent('exter-documents:notePadAnim:client', function()
    FreezeEntityPosition(PlayerPedId(), true)
    ClearPedTasks(PlayerPedId())
    TaskStartScenarioInPlace(PlayerPedId(), "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 0, true)
    Citizen.Wait(3000)
    FreezeEntityPosition(PlayerPedId(), false)
    ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('exter-documents:showToNearbyPlayers:client', function(type)
    if Config.CardTypes[type] and Config.EnableItemCheckOnTrigger then
        if DoItemCheck(Config.CardTypes[type].itemName) then
            local closestPlayer, closestDistance = getClosestPlayer(GetEntityCoords(PlayerPedId()))
            if closestPlayer ~= -1 then
                if closestDistance <= 3 then
                    TriggerServerEvent('exter-documents:showMyIdCardTo:server', type, GetPlayerServerId(closestPlayer))
                else
                    Notify(Lang:t("notify.no_nearby_players"), 7500, "error")
                end
            end
        else
            Notify(Lang:t("notify.dont_have_item", {type = type}), 7500, "error")
        end
    else
        Notify(Lang:t("notify.card_type_invalid", {type = type}), 7500, "error")
    end
end)

function DoItemCheck(name)
    if CoreName == "qb-core" or CoreName == "qbx_core" then
        local PlayerData = Core.Functions.GetPlayerData()
        for _, item in pairs(PlayerData.items) do
            if item.name == name then
                return true
            end
        end
        return false
    elseif CoreName == "es_extended" then
        if Core.IsPlayerLoaded() then
            local hasItem = Core.SearchInventory(name, 1) >= 1
            if hasItem then
                return true
            else
                return false
            end
        end
        return false
    end
end

function GetPlayers(onlyOtherPlayers, returnKeyValue, returnPeds)
    local players, myPlayer = {}, PlayerId()
    local active = GetActivePlayers()
    for i = 1, #active do
        local currentPlayer = active[i]
        local ped = GetPlayerPed(currentPlayer)
        if DoesEntityExist(ped) and ((onlyOtherPlayers and currentPlayer ~= myPlayer) or not onlyOtherPlayers) then
            if returnKeyValue then
                players[currentPlayer] = {entity = ped, id = GetPlayerServerId(currentPlayer)}
            else
                players[#players + 1] = returnPeds and ped or currentPlayer
            end
        end
    end
    return players
end

function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
    local nearbyEntities = {}
    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        local playerPed = PlayerPedId()
        coords = GetEntityCoords(playerPed)
    end
    for k, v in pairs(entities) do
        local distance = #(coords - GetEntityCoords(v.entity))
        if distance <= maxDistance then
            nearbyEntities[#nearbyEntities + 1] = v.id
        end
    end
    return nearbyEntities
end

function GetPlayersInArea(coords, maxDistance)
    return EnumerateEntitiesWithinDistance(GetPlayers(true, true), true, coords, maxDistance)
end

Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		local playerCoords = GetEntityCoords(PlayerPedId())
        for k, v in pairs(Config.LicenseAreas) do
            for a, b in pairs(v.Coords) do
                local dist = #(playerCoords - vector3(b.coords.x, b.coords.y, b.coords.z))
                if v.Interaction.Text.Enable then
                    if dist <= v.Interaction.Text.Distance then
                        local myJob = GetPlayerJob()
                        if v.Job == myJob then
                            sleep = 0
                            ShowFloatingHelpNotification(v.Interaction.Text.Label, vector3(b.coords.x, b.coords.y, b.coords.z))
                            if IsControlJustReleased(0, 38) then
                                createWeaponLicense()
                            end
                        end
                    end
                end
            end
        end
		Citizen.Wait(sleep)
	end
end)

closestLicenseArea = {}
local showTextUI2 = false
Citizen.CreateThread(function()
    for k, v in pairs(Config.LicenseAreas) do
        if v.Interaction.Target.Enable then
            for a, b in pairs(v.Coords) do
                if GetResourceState('ox_target') == 'started' or GetResourceState('qb-target') == 'started' then
                    if b.scale and b.width then
                        exports['qb-target']:AddBoxZone(k .. "_weplicense_boxZone_target", vector3(b.coords.x, b.coords.y, b.coords.z - 1), b.scale, b.width, {
                            name = k .. "_weplicense_boxZone_target",
                            heading = b.heading,
                            debugPoly = false,
                            minZ = b.coords.z - 1,
                            maxZ = b.coords.z + 1,
                        }, {
                            options = {
                                {
                                    num = 1,
                                    icon = v.Interaction.Target.Icon,
                                    label = v.Interaction.Target.Label,
                                    action = function()
                                        createWeaponLicense()
                                    end,
                                    job = v.Job,
                                }
                            },
                            distance = v.Interaction.Target.Distance,
                        })
                    end
				end
            end
        end
    end
	while true do
		local sleep = 100
		if not menuActive then
			playerPed = PlayerPedId()
			playerCoords = GetEntityCoords(playerPed)
			if not closestLicenseArea.id then
                for k, v in pairs(Config.LicenseAreas) do
                    if v.Interaction.DrawText.Enable then
                        for a, b in pairs(v.Coords) do
                            local dist = #(playerCoords - vector3(b.coords.x, b.coords.y, b.coords.z))
                            if dist <= v.Interaction.DrawText.Distance then
                                local myJob = GetPlayerJob()
                                if v.Job == myJob then
                                    function currentShow()
                                        v.Interaction.DrawText.Show()
                                        showTextUI2 = true
                                    end
                                    function currentHide()
                                        v.Interaction.DrawText.Hide()
                                    end
                                    closestLicenseArea = {id = k, distance = dist, maxDist = v.Interaction.DrawText.Distance, data = {coords = vector3(b.coords.x, b.coords.y, b.coords.z)}}
                                end
                            end
                        end
                    end
                end
			end
			if closestLicenseArea.id then
				while true do
                    playerPed = PlayerPedId()
					playerCoords = GetEntityCoords(playerPed)
					closestLicenseArea.distance = #(vector3(closestLicenseArea.data.coords.x, closestLicenseArea.data.coords.y, closestLicenseArea.data.coords.z) - playerCoords)
					if closestLicenseArea.distance < closestLicenseArea.maxDist then
						if IsControlJustReleased(0, 38) then
							createWeaponLicense()
						end
						if not showTextUI2 then
							currentShow()
						end
					else
						currentHide()
						break
					end
					Citizen.Wait(0)
				end
				showTextUI2 = false
				closestLicenseArea = {}
				sleep = 0
			end
		end
		Citizen.Wait(sleep)
	end
end)

if Config.CreateLicensesAuto then
    Citizen.CreateThread(function()
        while not CoreReady do Citizen.Wait(0) end
        if CoreName == "es_extended" then
            RegisterNetEvent('esx:playerLoaded')
            AddEventHandler("esx:playerLoaded", function(playerData, isNew, skin)
                if isNew then
                    TriggerServerEvent('exter-documents:createMeta:server')
                end
            end)
        end
    end)
end

Citizen.CreateThread(function()
    for k, v in pairs(Config.CardTypes) do
        RegisterNetEvent('exter-documents:' .. v.command .. ':client', function()
            ExecuteCommand(v.command)
        end)
    end
end)