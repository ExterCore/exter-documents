Core = nil
CoreName = nil
CoreReady = false
Citizen.CreateThread(function()
    for k, v in pairs(Cores) do
        if GetResourceState(v.ResourceName) == "starting" or GetResourceState(v.ResourceName) == "started" then
            CoreName = v.ResourceName
            Core = v.GetFramework()
            CoreReady = true
        end
    end
end)

function GetPlayer(id)
    if CoreName == "qb-core" or CoreName == "qbx_core" then
        local player = Core.Functions.GetPlayer(id)
        return player
    elseif CoreName == "es_extended" then
        local player = Core.GetPlayerFromId(id)
        return player
    end
end

function Notify(source, text, length, type)
    if CoreName == "qb-core" or CoreName == "qbx_core" then
        Core.Functions.Notify(source, text, type, length)
    elseif CoreName == "es_extended" then
        local player = Core.GetPlayerFromId(source)
        player.showNotification(text)
    end
end

function GetPlayerMoney(src, type)
    if CoreName == "qb-core" or CoreName == "qbx_core" then
        local player = Core.Functions.GetPlayer(src)
        return player.PlayerData.money[type]
    elseif CoreName == "es_extended" then
        local player = Core.GetPlayerFromId(src)
        local acType = "bank"
        if type == "cash" then
            acType = "money"
        end
        local account = player.getAccount(acType).money
        return account
    end
end

function RemoveMoney(src, type, amount, description)
    if CoreName == "qb-core" or CoreName == "qbx_core" then
        local player = Core.Functions.GetPlayer(src)
        player.Functions.RemoveMoney(type, amount, description)
    elseif CoreName == "es_extended" then
        local player = Core.GetPlayerFromId(src)
        if type == "bank" then
            player.removeAccountMoney("bank", amount, description)
        elseif type == "cash" then
            player.removeMoney(amount, description)
        end
    end
end

function AddItem(source, name, amount, metadata, type)
    if CoreName == "qb-core" or CoreName == "qbx_core" then
        local player = Core.Functions.GetPlayer(source)
        local hasQs = GetResourceState('qs-inventory') == 'started'
        if hasQs then
            return exports['qs-inventory']:AddItem(source, name, amount, false, metadata)
        end
        local hasOX = GetResourceState('ox_inventory') == 'started'
        if hasOX then
            metadata.imageurl = 'nui://ox_inventory/web/images/' .. Config.CardTypes[type].itemName .. '.png'
            return exports.ox_inventory:AddItem(source, name, amount, metadata)
        end
        local hasCodem = GetResourceState('codem-inventory') == 'started' or GetResourceState('mInventory') == 'started'
        if hasCodem then
            return exports["codem-inventory"]:AddItem(source, name, amount, nil, metadata)
        end
        local hasCore = GetResourceState('core_inventory') == 'started'
        if hasCore then
            local inventory = 'content-' ..  GetPlayerCid(source)
            return exports['core_inventory']:addItem(inventory, name, amount, metadata)
        end
        player.Functions.AddItem(name, amount, false, metadata)
    elseif CoreName == "es_extended" then
        local player = Core.GetPlayerFromId(source)
        local hasQs = GetResourceState('qs-inventory') == 'started'
        if hasQs then
            return exports['qs-inventory']:AddItem(source, name, amount, false, metadata)
        end
        local hasOX = GetResourceState('ox_inventory') == 'started'
        if hasOX then
            metadata.imageurl = 'nui://ox_inventory/web/images/' .. Config.CardTypes[type].itemName .. '.png'
            return exports.ox_inventory:AddItem(source, name, amount, metadata)
        end
        local hasCodem = GetResourceState('codem-inventory') == 'started' or GetResourceState('mInventory') == 'started'
        if hasCodem then
            return exports["codem-inventory"]:AddItem(source, name, amount, nil, metadata)
        end
        local hasCore = GetResourceState('core_inventory') == 'started'
        if hasCore then
            local inventory = 'content-' ..  GetPlayerCid(source):gsub(":", "")
            return exports['core_inventory']:addItem(inventory, name, amount, metadata)
        end
        player.addItem(name, amount)
    end
end

function RegisterUseableItem(name)
    while CoreReady == false do Citizen.Wait(0) end
    if CoreName == "qb-core" or CoreName == "qbx_core" then
        Core.Functions.CreateUseableItem(name, function(source, item)
            TriggerClientEvent('exter-documents:showIdCard:client', source, item.info or item.metadata, true)
        end)
    elseif CoreName == "es_extended" then
        local hasQs = GetResourceState('qs-inventory') == 'started'
        if hasQs then
            Core.RegisterUsableItem(name, function(source, item)
                TriggerClientEvent('exter-documents:showIdCard:client', source, item.info, true)
            end)
        end
        Core.RegisterUsableItem(name, function(source, _, item)
            TriggerClientEvent('exter-documents:showIdCard:client', source, item.metadata, true)
        end)
    end
end

Config.ServerCallbacks = {}
function CreateCallback(name, cb)
    Config.ServerCallbacks[name] = cb
end

function TriggerCallback(name, source, cb, ...)
    if not Config.ServerCallbacks[name] then return end
    Config.ServerCallbacks[name](source, cb, ...)
end

RegisterNetEvent('exter-documents:server:triggerCallback', function(name, ...)
    local src = source
    TriggerCallback(name, src, function(...)
        TriggerClientEvent('exter-documents:client:triggerCallback', src, name, ...)
    end, ...)
end)

function GetCharName(source)
    if CoreName == "qb-core" then
        local player = Core.Functions.GetPlayer(source)
        return player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname
    elseif CoreName == "es_extended" then
        local player = Core.GetPlayerFromId(source)
        return player.getName()
    end
end

function GetPlayerCid(source)
    if CoreName == "qb-core" or CoreName == "qbx_core" then
        local player = Core.Functions.GetPlayer(source)
        return player.PlayerData.citizenid
    elseif CoreName == "es_extended" then
        local player = Core.GetPlayerFromId(source)
        return player.getIdentifier()
    end
end

function HasItem(source, name)
    local src = tonumber(source)
    if CoreName == "qb-core" or CoreName == "qbx_core" then
        -- OX Inventory
        local hasOX = GetResourceState('ox_inventory') == 'started'
        if hasOX then
            if exports["ox_inventory"]:GetItem(src, name, nil, false) then
                return exports["ox_inventory"]:GetItem(src, name, nil, false).metadata
            end
        end
        -- QS Inventory
        local hasQs = GetResourceState('qs-inventory') == 'started'
        if hasQs then
            local items = exports['qs-inventory']:GetInventory(src)
            for item, data in pairs(items) do
                if item == name then
                    return data.metadata
                end
            end
        end
        -- Codem Inventory
        local hasCodem = GetResourceState('codem-inventory') == 'started'
        if hasCodem then
            local items = exports['codem-inventory']:GetInventory(false, src)
            for k, v in pairs(items) do
                if v.name == name then
                    return v.info
                end
            end
        end
        -- QB Inventory
        local qbPlayer = Core.Functions.GetPlayer(src)
        for _, item in pairs(qbPlayer.PlayerData.items) do
            if item.name == name then
                return item.info
            end
        end
        return nil
    elseif CoreName == "es_extended" then
        -- OX Inventory
        local hasOX = GetResourceState('ox_inventory') == 'started'
        if hasOX then
            if exports["ox_inventory"]:GetItem(src, name, nil, false) then
                return exports["ox_inventory"]:GetItem(src, name, nil, false).metadata
            end
        end
        -- Codem Inventory
        local hasCodem = GetResourceState('codem-inventory') == 'started'
        if hasCodem then
            local items = exports['codem-inventory']:GetInventory(false, src)
            for k, v in pairs(items) do
                if v.name == name then
                    return v.info
                end
            end
        end
        -- QS Inventory
        local hasQs = GetResourceState('qs-inventory') == 'started'
        if hasQs then
            local items = exports['qs-inventory']:GetInventory(src)
            for item, data in pairs(items) do
                if item == name then
                    return data.metadata
                end
            end
        end
        -- ESX Inventory
        local player = Core.GetPlayerFromId(src)
        local hasItem = player.getInventoryItem(name)
        if hasItem then
            return nil
        end
        return nil
    end
end

Citizen.CreateThread(function()
    for k, v in pairs(Config.CardTypes) do
        RegisterCommand(v.command, function(source)
            if v.itemControl == true or v.itemControl == nil then
                local item = HasItem(source, v.itemName)
                if item then
                    TriggerClientEvent('exter-documents:showIdCard:client', source, item, true)
                else
                    Notify(source, Lang:t("notify.dont_have_req_item"), 7500, "error")
                end
            elseif v.itemControl == false then
                local Player = GetPlayer(source)
                local metadata = {}
                local cMonth = os.date('%m'):match("0*(%d+)")
                local issueDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y')
                local expiredDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y') + 1
                if CoreName == "qb-core" or CoreName == "qbx_core" then
                    if k == "idcard" then
                        metadata = {
                            firstName = string.upper(Player.PlayerData.charinfo.firstname),
                            lastName = string.upper(Player.PlayerData.charinfo.lastname),
                            dob = string.upper(Player.PlayerData.charinfo.birthdate),
                            sex = GetStringSex(Player.PlayerData.charinfo.gender),
                            issuedon = issueDate,
                            expiredon = expiredDate,
                            citizenship = Player.PlayerData.citizenid,
                            nationality = Player.PlayerData.charinfo.nationality,
                            image = "default",
                            type = "idcard"
                        }
                    elseif k == "driverlicense" then
                        metadata = {
                            firstName = string.upper(Player.PlayerData.charinfo.firstname),
                            lastName = string.upper(Player.PlayerData.charinfo.lastname),
                            dob = string.upper(Player.PlayerData.charinfo.birthdate),
                            sex = GetStringSex(Player.PlayerData.charinfo.gender),
                            issuedon = issueDate,
                            expiredon = expiredDate,
                            citizenship = Player.PlayerData.citizenid,
                            class = Lang:t("general.driver_license_types"),
                            image = "default",
                            type = "driverlicense"
                        }
                    elseif k == "lspdbadge" then
                        metadata = {
                            firstName = string.upper(Player.PlayerData.charinfo.firstname),
                            lastName = string.upper(Player.PlayerData.charinfo.lastname),
                            dob = string.upper(Player.PlayerData.charinfo.birthdate),
                            sex = GetStringSex(Player.PlayerData.charinfo.gender),
                            issuedon = issueDate,
                            expiredon = expiredDate,
                            citizenship = string.upper(Player.PlayerData.job.name),
                            class = string.upper(Player.PlayerData.job.grade.name),
                            image = "default",
                            type = "lspdbadge"
                        }
                    elseif k == "lsmsbadge" then
                        metadata = {
                            firstName = string.upper(Player.variables.firstName),
                            lastName = string.upper(Player.variables.lastName),
                            dob = string.upper(Player.variables.dateofbirth),
                            sex = string.upper(Player.variables.sex),
                            issuedon = issueDate,
                            expiredon = expiredDate,
                            citizenship = string.upper(Player.job.label),
                            class = string.upper(Player.job["grade_label"]),
                            image = "default",
                            type = "lsmsbadge"
                        }
                    end
                end
                TriggerClientEvent('exter-documents:showIdCard:client', source, metadata, true)
            end
        end)
        RegisterNetEvent('exter-documents:' .. v.command .. ':server', function()
            local src = source
            if v.itemControl == true or v.itemControl == nil then
                local item = HasItem(src, v.itemName)
                if item then
                    TriggerClientEvent('exter-documents:showIdCard:client', src, item, true)
                else
                    Notify(src, Lang:t("notify.dont_have_req_item"), 7500, "error")
                end
            elseif v.itemControl == false then
                local Player = GetPlayer(src)
                local metadata = {}
                local cMonth = os.date('%m'):match("0*(%d+)")
                local issueDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y')
                local expiredDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y') + 1
                if CoreName == "qb-core" or CoreName == "qbx_core" then
                    if k == "idcard" then
                        metadata = {
                            firstName = string.upper(Player.PlayerData.charinfo.firstname),
                            lastName = string.upper(Player.PlayerData.charinfo.lastname),
                            dob = string.upper(Player.PlayerData.charinfo.birthdate),
                            sex = GetStringSex(Player.PlayerData.charinfo.gender),
                            issuedon = issueDate,
                            expiredon = expiredDate,
                            citizenship = Player.PlayerData.citizenid,
                            nationality = Player.PlayerData.charinfo.nationality,
                            image = "default",
                            type = "idcard"
                        }
                    elseif k == "driverlicense" then
                        metadata = {
                            firstName = string.upper(Player.PlayerData.charinfo.firstname),
                            lastName = string.upper(Player.PlayerData.charinfo.lastname),
                            dob = string.upper(Player.PlayerData.charinfo.birthdate),
                            sex = GetStringSex(Player.PlayerData.charinfo.gender),
                            issuedon = issueDate,
                            expiredon = expiredDate,
                            citizenship = Player.PlayerData.citizenid,
                            class = Lang:t("general.driver_license_types"),
                            image = "default",
                            type = "driverlicense"
                        }
                    elseif k == "lspdbadge" then
                        metadata = {
                            firstName = string.upper(Player.PlayerData.charinfo.firstname),
                            lastName = string.upper(Player.PlayerData.charinfo.lastname),
                            dob = string.upper(Player.PlayerData.charinfo.birthdate),
                            sex = GetStringSex(Player.PlayerData.charinfo.gender),
                            issuedon = issueDate,
                            expiredon = expiredDate,
                            citizenship = string.upper(Player.PlayerData.job.name),
                            class = string.upper(Player.PlayerData.job.grade.name),
                            image = "default",
                            type = "lspdbadge"
                        }
                    elseif k == "lsmsbadge" then
                        metadata = {
                            firstName = string.upper(Player.variables.firstName),
                            lastName = string.upper(Player.variables.lastName),
                            dob = string.upper(Player.variables.dateofbirth),
                            sex = string.upper(Player.variables.sex),
                            issuedon = issueDate,
                            expiredon = expiredDate,
                            citizenship = string.upper(Player.job.label),
                            class = string.upper(Player.job["grade_label"]),
                            image = "default",
                            type = "lsmsbadge"
                        }
                    end
                end
                TriggerClientEvent('exter-documents:showIdCard:client', src, metadata, true)
            end
        end)
    end
end)