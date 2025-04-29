RegisterNetEvent('exter-documents:createMeta:server', function(src)
    CreateMetaLicense(src)
end)

function CreateMetaLicense(src)
    local Player = GetPlayer(src)
    local metadataDriverLicense = {}
    local metadataIdCard = {}
    if CoreName == "qb-core" or CoreName == "qbx_core" then
        local cMonth = os.date('%m'):match("0*(%d+)")
        local issueDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y')
        local expiredDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y') + 1
        if Config.CardTypes["idcard"].useMetadata then
            metadataIdCard = {
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
        else
            metadataIdCard = {
                firstName = nil,
                lastName = nil,
                dob = nil,
                sex = nil,
                issuedon = issueDate,
                expiredon = expiredDate,
                citizenship = nil,
                nationality = nil,
                image = "default",
                type = "idcard"
            }
        end
        if Config.CardTypes["driverlicense"].useMetadata then
            metadataDriverLicense = {
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
        else
            metadataDriverLicense = {
                firstName = nil,
                lastName = nil,
                dob = nil,
                sex = nil,
                issuedon = issueDate,
                expiredon = expiredDate,
                citizenship = nil,
                class = Lang:t("general.driver_license_types"),
                image = "default",
                type = "driverlicense"
            }
        end
    elseif CoreName == "es_extended" then
        local cMonth = os.date('%m'):match("0*(%d+)")
        local issueDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y')
        local expiredDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y') + 1
        if Config.CardTypes["idcard"].useMetadata then
            metadataIdCard = {
                firstName = string.upper(Player.variables.firstName),
                lastName = string.upper(Player.variables.lastName),
                dob = string.upper(Player.variables.dateofbirth),
                sex = string.upper(Player.variables.sex),
                issuedon = issueDate,
                expiredon = expiredDate,
                citizenship = Lang:t("general.default_nationality_shortened") .. math.random(10000, 99999),
                nationality = Lang:t("general.default_nationality"),
                image = "default",
                type = "idcard"
            }
        else
            metadataIdCard = {
                firstName = nil,
                lastName = nil,
                dob = nil,
                sex = nil,
                issuedon = issueDate,
                expiredon = expiredDate,
                citizenship = Lang:t("general.default_nationality_shortened") .. math.random(10000, 99999),
                nationality = Lang:t("general.default_nationality"),
                image = "default",
                type = "idcard"
            }
        end
        if Config.CardTypes["driverlicense"].useMetadata then
            metadataDriverLicense = {
                firstName = string.upper(Player.variables.firstName),
                lastName = string.upper(Player.variables.lastName),
                dob = string.upper(Player.variables.dateofbirth),
                sex = string.upper(Player.variables.sex),
                issuedon = issueDate,
                expiredon = expiredDate,
                citizenship = Lang:t("general.default_nationality_shortened") .. math.random(10000, 99999),
                class = Lang:t("general.driver_license_types"),
                image = "default",
                type = "driverlicense"
            }
        else
            metadataDriverLicense = {
                firstName = nil,
                lastName = nil,
                dob = nil,
                sex = nil,
                issuedon = issueDate,
                expiredon = expiredDate,
                citizenship = Lang:t("general.default_nationality_shortened") .. math.random(10000, 99999),
                class = Lang:t("general.driver_license_types"),
                image = "default",
                type = "driverlicense"
            }
        end
    end
    AddItem(src, Config.CardTypes["idcard"].itemName, 1, metadataIdCard, "idcard")
    AddItem(src, Config.CardTypes["driverlicense"].itemName, 1, metadataDriverLicense, "driverlicense")
end

function GetStringSex(sexString)
    return sexString == 1 and Lang:t("general.female") or Lang:t("general.male")
end

RegisterNetEvent('exter-documents:buyIDCard', function(item, price, pedImage, id, weaponName, className)
    local itemAmount = 1
    local src = id or source
    local Player = GetPlayer(src)
    local paymentType = nil
    local playerCash = GetPlayerMoney(src, "cash")
    if playerCash >= price then
        paymentType = "cash"
    else
        return Notify(src, Lang:t("notify.not_enough_money"), 7500, "error")
    end
    local playerBank = GetPlayerMoney(src, "bank")
    if playerBank >= price then
        paymentType = "bank"
    else
        return Notify(src, Lang:t("notify.not_enough_money"), 7500, "error")
    end
    Notify(src, Lang:t("notify.bought", {item = item, amount = itemAmount}), 7500, "success")
    local metadata = {}
    if Config.CardTypes[item]["itemName"] == Config.CardTypes["idcard"]["itemName"] then
        if CoreName == "qb-core" or CoreName == "qbx_core" then
            local cMonth = os.date('%m'):match("0*(%d+)")
            local issueDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y')
            local expiredDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y') + 1
            if Config.CardTypes["idcard"].useMetadata then
                metadata = {
                    firstName = string.upper(Player.PlayerData.charinfo.firstname),
                    lastName = string.upper(Player.PlayerData.charinfo.lastname),
                    dob = string.upper(Player.PlayerData.charinfo.birthdate),
                    sex = GetStringSex(Player.PlayerData.charinfo.gender),
                    issuedon = issueDate,
                    expiredon = expiredDate,
                    citizenship = Player.PlayerData.citizenid,
                    nationality = Player.PlayerData.charinfo.nationality,
                    image = pedImage,
                    type = "idcard"
                }
            else
                metadata = {
                    firstName = nil,
                    lastName = nil,
                    dob = nil,
                    sex = nil,
                    issuedon = issueDate,
                    expiredon = expiredDate,
                    citizenship = nil,
                    nationality = nil,
                    image = pedImage,
                    type = "idcard"
                }
            end
        elseif CoreName == "es_extended" then
            local cMonth = os.date('%m'):match("0*(%d+)")
            local issueDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y')
            local expiredDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y') + 1
            if Config.CardTypes["idcard"].useMetadata then
                metadata = {
                    firstName = string.upper(Player.variables.firstName),
                    lastName = string.upper(Player.variables.lastName),
                    dob = string.upper(Player.variables.dateofbirth),
                    sex = string.upper(Player.variables.sex),
                    issuedon = issueDate,
                    expiredon = expiredDate,
                    citizenship = Lang:t("general.default_nationality_shortened") .. math.random(10000, 99999),
                    nationality = Lang:t("general.default_nationality"),
                    image = pedImage,
                    type = "idcard"
                }
            else
                metadata = {
                    firstName = nil,
                    lastName = nil,
                    dob = nil,
                    sex = nil,
                    issuedon = issueDate,
                    expiredon = expiredDate,
                    citizenship = Lang:t("general.default_nationality_shortened") .. math.random(10000, 99999),
                    nationality = Lang:t("general.default_nationality"),
                    image = pedImage,
                    type = "idcard"
                }
            end
        end
    elseif Config.CardTypes[item]["itemName"] == Config.CardTypes["driverlicense"]["itemName"] then
        if CoreName == "qb-core" or CoreName == "qbx_core" then
            local cMonth = os.date('%m'):match("0*(%d+)")
            local issueDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y')
            local expiredDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y') + 1
            if Config.CardTypes["driverlicense"].useMetadata then
                metadata = {
                    firstName = string.upper(Player.PlayerData.charinfo.firstname),
                    lastName = string.upper(Player.PlayerData.charinfo.lastname),
                    dob = string.upper(Player.PlayerData.charinfo.birthdate),
                    sex = GetStringSex(Player.PlayerData.charinfo.gender),
                    issuedon = issueDate,
                    expiredon = expiredDate,
                    citizenship = Player.PlayerData.citizenid,
                    class = Lang:t("general.driver_license_types"),
                    image = pedImage,
                    type = "driverlicense"
                }
            else
                metadata = {
                    firstName = nil,
                    lastName = nil,
                    dob = nil,
                    sex = nil,
                    issuedon = issueDate,
                    expiredon = expiredDate,
                    citizenship = nil,
                    class = Lang:t("general.driver_license_types"),
                    image = pedImage,
                    type = "driverlicense"
                }
            end
        elseif CoreName == "es_extended" then
            local cMonth = os.date('%m'):match("0*(%d+)")
            local issueDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y')
            local expiredDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y') + 1
            if Config.CardTypes["driverlicense"].useMetadata then
                metadata = {
                    firstName = string.upper(Player.variables.firstName),
                    lastName = string.upper(Player.variables.lastName),
                    dob = string.upper(Player.variables.dateofbirth),
                    sex = string.upper(Player.variables.sex),
                    issuedon = issueDate,
                    expiredon = expiredDate,
                    citizenship = Lang:t("general.default_nationality_shortened") .. math.random(10000, 99999),
                    class = Lang:t("general.driver_license_types"),
                    image = pedImage,
                    type = "driverlicense"
                }
            else
                metadata = {
                    firstName = nil,
                    lastName = nil,
                    dob = nil,
                    sex = nil,
                    issuedon = issueDate,
                    expiredon = expiredDate,
                    citizenship = Lang:t("general.default_nationality_shortened") .. math.random(10000, 99999),
                    class = Lang:t("general.driver_license_types"),
                    image = pedImage,
                    type = "driverlicense"
                }
            end
        end
    elseif Config.CardTypes[item]["itemName"] == Config.CardTypes["lspdbadge"]["itemName"] or Config.CardTypes[item]["itemName"] == Config.CardTypes["lsmsbadge"]["itemName"] then
        if CoreName == "qb-core" or CoreName == "qbx_core" then
            local cMonth = os.date('%m'):match("0*(%d+)")
            local issueDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y')
            local expiredDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y') + 1
            metadata = {
                firstName = string.upper(Player.PlayerData.charinfo.firstname),
                lastName = string.upper(Player.PlayerData.charinfo.lastname),
                dob = string.upper(Player.PlayerData.charinfo.birthdate),
                sex = GetStringSex(Player.PlayerData.charinfo.gender),
                issuedon = issueDate,
                expiredon = expiredDate,
                citizenship = string.upper(Player.PlayerData.job.name),
                class = string.upper(Player.PlayerData.job.grade.name),
                image = pedImage,
                type = item
            }
        elseif CoreName == "es_extended" then
            local cMonth = os.date('%m'):match("0*(%d+)")
            local issueDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y')
            local expiredDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y') + 1
            metadata = {
                firstName = string.upper(Player.variables.firstName),
                lastName = string.upper(Player.variables.lastName),
                dob = string.upper(Player.variables.dateofbirth),
                sex = string.upper(Player.variables.sex),
                issuedon = issueDate,
                expiredon = expiredDate,
                citizenship = string.upper(Player.job.label),
                class = string.upper(Player.job["grade_label"]),
                image = pedImage,
                type = item
            }
        end
    elseif Config.CardTypes[item]["itemName"] == Config.CardTypes["weaponlicense"]["itemName"] then
        if not weaponName and not className then
            return Notify(src, Lang:t("notify.cannot_be_left_empty"), 7500, "error")
        end
        local type = "weaponlicense"
        item = "weaponlicense"
        if CoreName == "qb-core" or CoreName == "qbx_core" then
            local licenseTable = Player.PlayerData.metadata['licences']
            if not licenseTable[type] then
                licenseTable[type] = true
                Player.Functions.SetMetaData('licences', licenseTable)
            end
            local cMonth = os.date('%m'):match("0*(%d+)")
            local issueDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y')
            local expiredDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y') + 1
            metadata = {
                firstName = string.upper(Player.PlayerData.charinfo.firstname),
                lastName = string.upper(Player.PlayerData.charinfo.lastname),
                dob = string.upper(Player.PlayerData.charinfo.birthdate),
                sex = GetStringSex(Player.PlayerData.charinfo.gender),
                issuedon = issueDate,
                expiredon = expiredDate,
                citizenship = weaponName,
                class = className,
                image = "default",
                type = type
            }
        elseif CoreName == "es_extended" then
            local cMonth = os.date('%m'):match("0*(%d+)")
            local issueDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y')
            local expiredDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y') + 1
            metadata = {
                firstName = string.upper(Player.variables.firstName),
                lastName = string.upper(Player.variables.lastName),
                dob = string.upper(Player.variables.dateofbirth),
                sex = string.upper(Player.variables.sex),
                issuedon = issueDate,
                expiredon = expiredDate,
                citizenship = weaponName,
                class = className,
                image = "default",
                type = type
            }
        end
    elseif Config.CardTypes[item]["itemName"] == Config.CardTypes["huntinglicense"]["itemName"] then
        if not weaponName and not className then
            return Notify(src, Lang:t("notify.cannot_be_left_empty"), 7500, "error")
        end
        local type = "huntinglicense"
        item = "huntinglicense"
        if CoreName == "qb-core" or CoreName == "qbx_core" then
            local licenseTable = Player.PlayerData.metadata['licences']
            if not licenseTable["hunterlicense"] then
                licenseTable["hunterlicense"] = true
                Player.Functions.SetMetaData('licences', licenseTable)
            end
            local cMonth = os.date('%m'):match("0*(%d+)")
            local issueDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y')
            local expiredDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y') + 1
            metadata = {
                firstName = string.upper(Player.PlayerData.charinfo.firstname),
                lastName = string.upper(Player.PlayerData.charinfo.lastname),
                dob = string.upper(Player.PlayerData.charinfo.birthdate),
                sex = GetStringSex(Player.PlayerData.charinfo.gender),
                issuedon = issueDate,
                expiredon = expiredDate,
                citizenship = weaponName,
                class = className,
                image = "default",
                type = type
            }
        elseif CoreName == "es_extended" then
            local cMonth = os.date('%m'):match("0*(%d+)")
            local issueDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y')
            local expiredDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y') + 1
            metadata = {
                firstName = string.upper(Player.variables.firstName),
                lastName = string.upper(Player.variables.lastName),
                dob = string.upper(Player.variables.dateofbirth),
                sex = string.upper(Player.variables.sex),
                issuedon = issueDate,
                expiredon = expiredDate,
                citizenship = weaponName,
                class = className,
                image = "default",
                type = type
            }
        end
    end
    Citizen.Wait(500)
    RemoveMoney(src, paymentType, price)
    AddItem(src, Config.CardTypes[item].itemName, itemAmount, metadata, item)
end)

RegisterServerEvent('exter-documents:showIdCard:server', function(metadata, id)
    TriggerClientEvent('exter-documents:showIdCard:clientother', id, metadata, false)
end)

RegisterUseableItem(Config.CardTypes["idcard"].itemName)
RegisterUseableItem(Config.CardTypes["driverlicense"].itemName)
RegisterUseableItem(Config.CardTypes["lspdbadge"].itemName)
RegisterUseableItem(Config.CardTypes["lsmsbadge"].itemName)
RegisterUseableItem(Config.CardTypes["weaponlicense"].itemName)
RegisterUseableItem(Config.CardTypes["huntinglicense"].itemName)
exports('CreateMetaLicense', CreateMetaLicense)

Citizen.CreateThread(function()
    while CoreReady == false do Citizen.Wait(0) end
    local hasOX = GetResourceState('ox_inventory') == 'started'
    if hasOX then
        exports('idcard', function(event, item, inventory, slot, data)
            if event == 'usingItem' then
                local itemSlot = exports.ox_inventory:GetSlot(inventory.id, slot)
                TriggerClientEvent('exter-documents:showIdCard:client', inventory.id, itemSlot.metadata, true)
            end
        end)
        exports('driverlicense', function(event, item, inventory, slot, data)
            if event == 'usingItem' then
                local itemSlot = exports.ox_inventory:GetSlot(inventory.id, slot)
                TriggerClientEvent('exter-documents:showIdCard:client', inventory.id, itemSlot.metadata, true)
            end
        end)
        exports('lspdbadge', function(event, item, inventory, slot, data)
            if event == 'usingItem' then
                local itemSlot = exports.ox_inventory:GetSlot(inventory.id, slot)
                TriggerClientEvent('exter-documents:showIdCard:client', inventory.id, itemSlot.metadata, true)
            end
        end)
        exports('lsmsbadge', function(event, item, inventory, slot, data)
            if event == 'usingItem' then
                local itemSlot = exports.ox_inventory:GetSlot(inventory.id, slot)
                TriggerClientEvent('exter-documents:showIdCard:client', inventory.id, itemSlot.metadata, true)
            end
        end)
        exports('weaponlicense2', function(event, item, inventory, slot, data)
            if event == 'usingItem' then
                local itemSlot = exports.ox_inventory:GetSlot(inventory.id, slot)
                TriggerClientEvent('exter-documents:showIdCard:client', inventory.id, itemSlot.metadata, true)
            end
        end)
        exports('huntinglicense', function(event, item, inventory, slot, data)
            if event == 'usingItem' then
                local itemSlot = exports.ox_inventory:GetSlot(inventory.id, slot)
                TriggerClientEvent('exter-documents:showIdCard:client', inventory.id, itemSlot.metadata, true)
            end
        end)
    end
end)

RegisterNetEvent('exter-documents:showMyIdCardTo:server', function(type, id)
    local src = source
    local Player = GetPlayer(src)
    local metadata = {}
    if type == "idcard" then
        if CoreName == "qb-core" or CoreName == "qbx_core" then
            local cMonth = os.date('%m'):match("0*(%d+)")
            local issueDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y')
            local expiredDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y') + 1
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
            return TriggerClientEvent('exter-documents:showIdCard:client', src, metadata, true)
        elseif CoreName == "es_extended" then
            local cMonth = os.date('%m'):match("0*(%d+)")
            local issueDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y')
            local expiredDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y') + 1
            metadata = {
                firstName = string.upper(Player.variables.firstName),
                lastName = string.upper(Player.variables.lastName),
                dob = string.upper(Player.variables.dateofbirth),
                sex = string.upper(Player.variables.sex),
                issuedon = issueDate,
                expiredon = expiredDate,
                citizenship = Lang:t("general.default_nationality_shortened") .. math.random(10000, 99999),
                nationality = Lang:t("general.default_nationality"),
                image = "default",
                type = "idcard"
            }
            return TriggerClientEvent('exter-documents:showIdCard:client', src, metadata, true)
        end
    elseif type == "driverlicense" then
        if CoreName == "qb-core" or CoreName == "qbx_core" then
            local cMonth = os.date('%m'):match("0*(%d+)")
            local issueDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y')
            local expiredDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y') + 1
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
            return TriggerClientEvent('exter-documents:showIdCard:client', src, metadata, true)
        elseif CoreName == "es_extended" then
            local cMonth = os.date('%m'):match("0*(%d+)")
            local issueDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y')
            local expiredDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y') + 1
            metadata = {
                firstName = string.upper(Player.variables.firstName),
                lastName = string.upper(Player.variables.lastName),
                dob = string.upper(Player.variables.dateofbirth),
                sex = string.upper(Player.variables.sex),
                issuedon = issueDate,
                expiredon = expiredDate,
                citizenship = Lang:t("general.default_nationality_shortened") .. math.random(10000, 99999),
                class = Lang:t("general.driver_license_types"),
                image = "default",
                type = "driverlicense"
            }
            return TriggerClientEvent('exter-documents:showIdCard:client', src, metadata, true)
        end
    elseif type == "lspdbadge" or type == "lsmsbadge" then
        if CoreName == "qb-core" or CoreName == "qbx_core" then
            local cMonth = os.date('%m'):match("0*(%d+)")
            local issueDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y')
            local expiredDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y') + 1
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
                type = type
            }
            return TriggerClientEvent('exter-documents:showIdCard:client', src, metadata, true)
        elseif CoreName == "es_extended" then
            local cMonth = os.date('%m'):match("0*(%d+)")
            local issueDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y')
            local expiredDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y') + 1
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
                type = type
            }
            return TriggerClientEvent('exter-documents:showIdCard:client', src, metadata, true)
        end
    end
end)

CreateCallback('exter-documents:getNearbyPlayerDatas:server', function(source, cb, nearbyPlayers)
    local nearbyPlayers2 = {}
    for _, id in pairs(nearbyPlayers) do
        local numPlayerId = tonumber(id)
        local numPlayerName = GetCharName(numPlayerId)
        local numPlayerCitizenId = GetPlayerCid(numPlayerId)
        table.insert(nearbyPlayers2, {
            id = numPlayerId,
            name = numPlayerName,
            cid = numPlayerCitizenId
        })
    end
    cb(nearbyPlayers2)
end)

RegisterNetEvent('exter-documents:createWeaponLicense:server', function(data)
    local src = source
    local targetPlayer = GetPlayer(data.targetId)
    local metadata = {}
    local item = nil
    local type = "weaponlicense"
    if data.type == "Hunting" then type = "huntinglicense" end
    if Config.CardTypes[type] then
        item = Config.CardTypes[type].itemName
    end
    if CoreName == "qb-core" or CoreName == "qbx_core" then
        local licenseTable = targetPlayer.PlayerData.metadata['licences']
        if not licenseTable[type] then
            licenseTable[type] = true
            if type == "huntinglicense" then
                licenseTable["hunterlicense"] = true
            end
            targetPlayer.Functions.SetMetaData('licences', licenseTable)
        end
        local cMonth = os.date('%m'):match("0*(%d+)")
        local issueDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y')
        local expiredDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y') + 1
        metadata = {
            firstName = string.upper(targetPlayer.PlayerData.charinfo.firstname),
            lastName = string.upper(targetPlayer.PlayerData.charinfo.lastname),
            dob = string.upper(targetPlayer.PlayerData.charinfo.birthdate),
            sex = GetStringSex(targetPlayer.PlayerData.charinfo.gender),
            issuedon = issueDate,
            expiredon = expiredDate,
            citizenship = data.weaponName,
            class = data.className,
            image = "default",
            type = type
        }
    elseif CoreName == "es_extended" then
        local cMonth = os.date('%m'):match("0*(%d+)")
        local issueDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y')
        local expiredDate = Config.Months[tonumber(cMonth)] .. " " .. os.date('%d') .. ", " .. os.date('%Y') + 1
        metadata = {
            firstName = string.upper(targetPlayer.variables.firstName),
            lastName = string.upper(targetPlayer.variables.lastName),
            dob = string.upper(targetPlayer.variables.dateofbirth),
            sex = string.upper(targetPlayer.variables.sex),
            issuedon = issueDate,
            expiredon = expiredDate,
            citizenship = data.weaponName,
            class = data.className,
            image = "default",
            type = type
        }
    end
    RemoveMoney(data.targetId, "bank", data.price)
    AddItem(data.targetId, item, 1, metadata, type)
    TriggerClientEvent('exter-documents:notePadAnim:client', src)
    TriggerClientEvent('exter-documents:notePadAnim:client', data.targetId)
end)

Citizen.CreateThread(function()
    while not CoreReady do Citizen.Wait(0) end
    if CoreName == "qb-core" or CoreName == "qbx_core" then
        Core.Commands.Add('givecard', Lang:t("command.description"), {{name = 'id', help = Lang:t("command.arg1")}, {name = 'Card Type', help = Lang:t("command.arg2")}}, true, function(source, args)
            if args[1] and args[2] then
                local target = GetPlayer(tonumber(args[1]))
                if target then
                    -- for k, v in pairs(Config.CardTypes) do
                    --     if v.itemName == args[2] then
                    --         TriggerEvent('exter-documents:buyIDCard', v.itemName, 0, "default", tonumber(args[1]), args[3], args[4])
                    --     else
                    --         Notify(source, Lang:t("notify.card_type_invalid", {type = args[2]}), 7500, "error")
                    --     end
                    -- end
                    if Config.CardTypes[args[2]] then
                        TriggerEvent('exter-documents:buyIDCard', args[2], 0, "default", tonumber(args[1]), args[3], args[4])
                    else
                        Notify(source, Lang:t("notify.card_type_invalid", {type = args[2]}), 7500, "error")
                    end
                end
            end
        end, 'admin')
    elseif CoreName == "es_extended" then
        Core.RegisterCommand("givecard", "admin", function(xPlayer, args, showError)
            if args.id and args.type then
                local target = GetPlayer(tonumber(args.id))
                if target then
                    if Config.CardTypes[args.type] then
                        TriggerEvent('exter-documents:buyIDCard', args.type, 0, "default", tonumber(args.id))
                    else
                        Notify(source, Lang:t("notify.card_type_invalid", {type = args.type}), 7500, "error")
                    end
                end
            end
        end, true, {
            help = Lang:t("command.description"),
            validate = true,
            arguments = {
                {name = "id", help = Lang:t("command.arg1"), type = "number"},
                {name = "type", help = Lang:t("command.arg2"), type = "string"}
            },
        }
    )
    end
end)
