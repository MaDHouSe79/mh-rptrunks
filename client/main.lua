--[[ ===================================================== ]] --
--[[             MH RP Trunks Script by MaDHouSe           ]] --
--[[ ===================================================== ]] --
local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local vehicleData = {}
local vehicles = {}
local currentVehicle = nil
local itemEntity = nil
local hasItem = false
local isTrunkOpen = false
local isLoaded = false
local isCokeLoaded = false
local isBoxLoaded = false
local isDrankLoaded = false
local isWeedLoaded = false
local isLoggedIn = false
local targetScript = nil

local function DisplayHelpText(text)
    SetTextComponentFormat('STRING')
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local function GetModelName(vehicle)
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
    print(model)
    return model:lower()
end

local function LoadModel(model)
    if not HasModelLoaded(dict) then
        RequestModel(model)
        while not HasModelLoaded(model) do Wait(1) end
    end
end

local function LoadAnimDict(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do Wait(1) end
    end
end

local function DeleteAllBoxes()
    for model, data in pairs(vehicles) do
        for id, storage in pairs(data.storages) do
            if DoesEntityExist(storage.entity) then DeleteEntity(storage.entity) end
            storage.entity = nil
            storage.loaded = false
            data.countCapacity = 0
        end
    end
    isLoaded = false
    isCokeLoaded = false
    isBoxLoaded = false
    isDrankLoaded = false
    isWeedLoaded = false
end

local function RemoveStuckProp()
    local ped = PlayerPedId()
    for _, v in pairs(GetGamePool('CObject')) do
        if IsEntityAttachedToEntity(ped, v) then
            SetEntityAsMissionEntity(v, true, true)
            DeleteObject(v)
            DeleteEntity(v)
        end
    end
    hasItem = false
    itemEntity = nil
    ClearPedSecondaryTask(ped)
end

local function GetProp(vehicle, _type)
    local model = GetModelName(vehicle)
    if vehicles[model] then
        if type(vehicles[model].prop) == 'table' then
            if _type == 'coke_brick' then
                return vehicles[model].prop.coke
            elseif _type == 'weed_brick' then
                return vehicles[model].prop.weed
            elseif _type == 'boxen' then
                return vehicles[model].prop.box
            elseif _type == 'drank' then
                return vehicles[model].prop.drank
            end
        elseif type(vehicles[model].prop) == 'string' then
            return vehicles[model].prop
        end
    end
end

local function TakeItem(prop)
    local player = PlayerPedId()
    LoadAnimDict("anim@heists@box_carry@")
    if not IsPedInAnyVehicle(player, false) and (DoesEntityExist(player) and not IsEntityDead(player)) and not hasItem then
        local x, y, z = table.unpack(GetEntityCoords(player))
        LoadModel(GetHashKey(prop))
        itemEntity = CreateObject(GetHashKey(prop), x, y, z + 0.2,  true,  true, false)
        AttachEntityToEntity(itemEntity, player, GetPedBoneIndex(player, 60309), 0.2, 0.08, 0.2, -45.0, 290.0, 0.0, true, true, false, true, 1, true)
        TaskPlayAnim( player, "anim@heists@box_carry@", "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
        hasItem = true
    end
end

local function DropItem()
    local player = PlayerPedId()
    LoadAnimDict("anim@heists@box_carry@")
    if not IsPedInAnyVehicle(player, false) and (DoesEntityExist(player) and not IsEntityDead(player)) and hasItem then
        TaskPlayAnim(player, "anim@heists@box_carry@", "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0 )
        DetachEntity(itemEntity, 1, 1)
        DeleteObject(itemEntity)
        itemEntity = nil
        Wait(1000)
        ClearPedSecondaryTask(PlayerPedId())
        hasItem = false
    end
end

local function AddItemToTrunk(vehicle)
    local model = GetModelName(vehicle)
    if vehicles[model] then
        local vehicleData = vehicles[model]
        for _, storage in pairs(vehicleData.storages) do
            if vehicleData.countCapacity < vehicleData.maxCapacity and not storage.loaded then
                storage.loaded = true
                local prop = GetProp(vehicle, storage.itemType)
                LoadModel(GetHashKey(prop))
                local box = CreateObject(GetHashKey(prop), storage.coords.x, storage.coords.y, storage.coords.z, true, true, false)
                AttachEntityToEntity(box, vehicle, 0, storage.coords.x, storage.coords.y, storage.coords.z - 0.2, storage.rotation.x, storage.rotation.y, storage.rotation.z, true, true, false, true, 1, true)
                storage.entity = box
                vehicleData.countCapacity = vehicleData.countCapacity + 1
                DropItem()
                break
            end
        end
    end
end

local function CloseAllDoorsAndUnload(vehicle)
    for i = 1, 7, 1 do
        SetVehicleDoorShut(vehicle, i, false)
    end
    isTrunkOpen = false
    isLoaded = false
    isCokeLoaded = false
    isBoxLoaded = false
    isDrankLoaded = false
    isWeedLoaded = false
end

local function RemoveItemFromTrunk(vehicle)
    local model = GetModelName(vehicle)
    if vehicles[model] then
        local vehicleData = vehicles[model]
        for id, storage in pairs(vehicleData.storages) do
            if storage and storage.loaded and vehicleData.countCapacity > 0 and DoesEntityExist(storage.entity) then
                DeleteEntity(storage.entity)
                vehicleData.countCapacity = vehicleData.countCapacity - 1
                storage.entity = nil
                storage.loaded = false
                local prop = GetProp(vehicle, storage.itemType)
                TakeItem(prop)
                if vehicleData.countCapacity <= 0 then 
                    DeleteAllBoxes()
                    CloseAllDoorsAndUnload(vehicle)
                end
                break
            end
        end
    end
end

local function ToggleDoor(vehicle, doors)
    currentVehicle = vehicle
    isTrunkOpen = not isTrunkOpen
    if type(doors) == 'number' then
        if isTrunkOpen then
            SetVehicleDoorOpen(vehicle, doors, false)
        elseif not isTrunkOpen then
            SetVehicleDoorShut(vehicle, doors, false)
        end
    elseif type(doors) == 'table' then
        for _, door in pairs(doors) do
            if isTrunkOpen then
                SetVehicleDoorOpen(vehicle, door, false)
            elseif not isTrunkOpen then
                SetVehicleDoorShut(vehicle, door, false)
            end
        end
    end
end

local function LoadVehicleWithItems(vehicle, _type)
    if isLoggedIn then
        local model = GetModelName(vehicle)
        if vehicles[model] then
            local prop = GetProp(vehicle, _type)
            LoadModel(GetHashKey(prop))
            for _, storage in pairs(vehicles[model].storages) do
                if vehicles[model].countCapacity < vehicles[model].maxCapacity and not storage.loaded then
                    vehicles[model].countCapacity = vehicles[model].countCapacity + 1
                    local box = CreateObject(GetHashKey(prop), storage.coords.x, storage.coords.y, storage.coords.z, true, true, false)
                    AttachEntityToEntity(box, vehicle, 0, storage.coords.x, storage.coords.y, storage.coords.z - 0.2, storage.rotation.x, storage.rotation.y, storage.rotation.z, true, true, false, true, 1, true)
                    storage.loaded = true
                    storage.entity = box
                    storage.itemType = _type
                end
            end
            isLoaded = true
        end
    end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    TriggerServerEvent('mh-rptrunks:server:refreshConfig')
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        PlayerData = QBCore.Functions.GetPlayerData()
        currentVehicle = nil
        hasItem = false
        isTrunkOpen = false
        itemEntity = nil
        isLoaded = false
        TriggerServerEvent('mh-rptrunks:server:refreshConfig')
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        DeleteAllBoxes()
    end
end)

RegisterNetEvent('mh-rptrunks:client:CreateVehicleTarget', function(netid, door)
    local vehicle = NetworkGetEntityFromNetworkId(netid)
    if DoesEntityExist(vehicle) then
        if targetScript == "qb-target" then
            exports['qb-target']:AddTargetEntity(netid, {
                options = {
                    {
                        type = "client",
                        icon = "fas fa-car",
                        label = Lang:t('target.load_prop'),
                        action = function(entity)
                            AddItemToTrunk(entity)
                        end,
                        canInteract = function(entity, distance, data)
                            if IsPedAPlayer(entity) then return false end
                            if not hasItem then return false end
                            if not isLoaded then return false end
                            if GetVehicleDoorAngleRatio(entity, door) <= 0.0 then return false end
                            return true
                        end
                    }, {
                        type = "client",
                        icon = "fas fa-car",
                        label = Lang:t('target.take_prop'),
                        action = function(entity)
                            RemoveItemFromTrunk(entity)
                        end,
                        canInteract = function(entity, distance, data)
                            if IsPedAPlayer(entity) then return false end
                            if hasItem then return false end
                            if not isLoaded then return false end
                            if GetVehicleDoorAngleRatio(entity, door) <= 0.0 then return false end
                            return true
                        end
                    }, 
                    {
                        type = "client",
                        icon = "fas fa-car",
                        label = Lang:t('target.load_coke'),
                        action = function(entity)
                            isCokeLoaded = true
                            DeleteAllBoxes()
                            LoadVehicleWithItems(entity, 'coke_brick')
                        end,
                        canInteract = function(entity, distance, data)
                            if IsPedAPlayer(entity) then return false end
                            if isLoaded then return false end
                            if GetVehicleDoorAngleRatio(entity, door) <= 0.0 then return false end
                            if isCokeLoaded then return false end
                            if isDrankLoaded then return false end
                            if isBoxLoaded then return false end
                            if isWeedLoaded then return false end                 
                            return true
                        end
                    },
                    {
                        type = "client",
                        icon = "fas fa-car",
                        label = Lang:t('target.load_weed'),
                        action = function(entity)
                            isWeedLoaded = true
                            DeleteAllBoxes()
                            LoadVehicleWithItems(entity, 'weed_brick')
                        end,
                        canInteract = function(entity, distance, data)
                            if IsPedAPlayer(entity) then return false end
                            if isLoaded then return false end
                            if GetVehicleDoorAngleRatio(entity, door) <= 0.0 then return false end
                            if isWeedLoaded then return false end
                            if isDrankLoaded then return false end
                            if isBoxLoaded then return false end
                            if isCokeLoaded then return false end
                            return true
                        end
                    },
                    {
                        type = "client",
                        icon = "fas fa-car",
                        label = Lang:t('target.load_boxes'),
                        action = function(entity)
                            isBoxLoaded = true
                            DeleteAllBoxes()
                            LoadVehicleWithItems(entity, 'boxen')
                        end,
                        canInteract = function(entity, distance, data)
                            if IsPedAPlayer(entity) then return false end
                            if isLoaded then return false end
                            if GetVehicleDoorAngleRatio(entity, door) <= 0.0 then return false end
                            if isBoxLoaded then return false end  
                            if isDrankLoaded then return false end
                            if isCokeLoaded then return false end
                            if isWeedLoaded then return false end                      
                            return true
                        end
                    },
                    {
                        type = "client",
                        icon = "fas fa-car",
                        label = Lang:t('target.load_drank'),
                        action = function(entity)
                            isDrankLoaded = true
                            DeleteAllBoxes()
                            LoadVehicleWithItems(entity, 'drank')
                        end,
                        canInteract = function(entity, distance, data)
                            if IsPedAPlayer(entity) then return false end
                            if isLoaded then return false end
                            if GetVehicleDoorAngleRatio(entity, door) <= 0.0 then return false end
                            if isDrankLoaded then return false end
                            if isBoxLoaded then return false end
                            if isCokeLoaded then return false end
                            if isWeedLoaded then return false end
                            return true
                        end
                    },
                    {
                        type = "client",
                        icon = "fas fa-car",
                        label = Lang:t('target.unload_trunk'),
                        action = function(entity)
                            DeleteAllBoxes()
                            isCokeLoaded = false
                            isBoxLoaded = false
                        end,
                        canInteract = function(entity, distance, data)
                            if IsPedAPlayer(entity) then return false end
                            if not isLoaded then return false end
                            if GetVehicleDoorAngleRatio(entity, door) <= 0.0 then return false end
                            return true
                        end
                    },
                },
                distance = 5.0
            })
        elseif targetScript == "ox_target" then
            exports.ox_target:addEntity(netid, {
                {
                    type = "client",
                    icon = "fas fa-car",
                    label = Lang:t('target.load_prop'),
                    onSelect = function(data)
                        AddItemToTrunk(data.entity)
                    end,
                    canInteract = function(entity, distance, data)
                        if IsPedAPlayer(entity) then return false end
                        if not hasItem then return false end
                        if not isLoaded then return false end
                        if GetVehicleDoorAngleRatio(entity, door) <= 0.0 then return false end
                        return true
                    end,
                    distance = 5.0
                },
                {
                    type = "client",
                    icon = "fas fa-car",
                    label = Lang:t('target.take_prop'),
                    onSelect = function(data)
                        RemoveItemFromTrunk(data.entity)
                    end,
                    canInteract = function(entity, distance, data)
                        if IsPedAPlayer(entity) then return false end
                            if hasItem then return false end
                            if not isLoaded then return false end
                            if GetVehicleDoorAngleRatio(entity, door) <= 0.0 then return false end
                        return true
                    end,
                    distance = 5.0
                },
                {
                    type = "client",
                    icon = "fas fa-car",
                    label = Lang:t('target.load_coke'),
                    onSelect = function(data)
                        isCokeLoaded = true
                        DeleteAllBoxes()
                        LoadVehicleWithItems(data.entity, 'coke_brick')
                    end,
                    canInteract = function(entity, distance, data)
                        if IsPedAPlayer(entity) then return false end
                        if isLoaded then return false end
                        if GetVehicleDoorAngleRatio(entity, door) <= 0.0 then return false end
                        if isCokeLoaded then return false end
                        if isDrankLoaded then return false end
                        if isBoxLoaded then return false end
                        if isWeedLoaded then return false end 
                        return true
                    end,
                    distance = 5.0
                },
                {
                    type = "client",
                    icon = "fas fa-car",
                    label = Lang:t('target.load_weed'),
                    onSelect = function(data)
                        isWeedLoaded = true
                        DeleteAllBoxes()
                        LoadVehicleWithItems(data.entity, 'weed_brick')
                    end,
                    canInteract = function(entity, distance, data)
                        if IsPedAPlayer(entity) then return false end
                        if isLoaded then return false end
                        if GetVehicleDoorAngleRatio(entity, door) <= 0.0 then return false end
                        if isWeedLoaded then return false end
                        if isDrankLoaded then return false end
                        if isBoxLoaded then return false end
                        if isCokeLoaded then return false end
                        return true
                    end,
                    distance = 5.0
                },
                {
                    type = "client",
                    icon = "fas fa-car",
                    label = Lang:t('target.load_boxes'),
                    onSelect = function(data)
                        isBoxLoaded = true
                        DeleteAllBoxes()
                        LoadVehicleWithItems(data.entity, 'boxen')
                    end,
                    canInteract = function(entity, distance, data)
                        if IsPedAPlayer(entity) then return false end
                        if isLoaded then return false end
                        if GetVehicleDoorAngleRatio(entity, door) <= 0.0 then return false end
                        if isBoxLoaded then return false end  
                        if isDrankLoaded then return false end
                        if isCokeLoaded then return false end
                        if isWeedLoaded then return false end  
                        return true
                    end,
                    distance = 5.0
                },
                {
                    type = "client",
                    icon = "fas fa-car",
                    label = Lang:t('target.load_drank'),
                    onSelect = function(data)
                        isDrankLoaded = true
                        DeleteAllBoxes()
                        LoadVehicleWithItems(data.entity, 'drank')
                    end,
                    canInteract = function(entity, distance, data)
                        if IsPedAPlayer(entity) then return false end
                        if isLoaded then return false end
                        if GetVehicleDoorAngleRatio(entity, door) <= 0.0 then return false end
                        if isDrankLoaded then return false end
                        if isBoxLoaded then return false end
                        if isCokeLoaded then return false end
                        if isWeedLoaded then return false end 
                        return true
                    end,
                    distance = 5.0
                },
                {
                    type = "client",
                    icon = "fas fa-car",
                    label = Lang:t('target.unload_trunk'),
                    onSelect = function(data)
                        DeleteAllBoxes()
                        isCokeLoaded = false
                        isBoxLoaded = false
                    end,
                    canInteract = function(entity, distance, data)
                        if IsPedAPlayer(entity) then return false end
                        if not isLoaded then return false end
                        if GetVehicleDoorAngleRatio(entity, door) <= 0.0 then return false end
                        return true
                    end,
                    distance = 5.0
                },
            })
        end
    end
end)

RegisterNetEvent('mh-rptrunks:client:sendConfig', function(config, target)
    vehicles = config
    targetScript = target
    isLoggedIn = true
end)

CreateThread(function()
    while true do
        Wait(0)
        if isLoggedIn and hasItem then
            DisplayHelpText(Lang:t('info.press_to_drop'))
            if IsControlJustPressed(0, 38) then RemoveStuckProp() end
        end
    end
end)
