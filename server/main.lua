--[[ ===================================================== ]] --
--[[             MH RP Trunks Script by MaDHouSe           ]] --
--[[ ===================================================== ]] --
local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('mh-rptrunks:server:refreshConfig')
AddEventHandler('mh-rptrunks:server:refreshConfig', function()
    local src = source
    TriggerClientEvent('mh-rptrunks:client:sendConfig', src, SV_Config.Vehicles, SV_Config.Animations)
end)

RegisterNetEvent('entityCreating')
AddEventHandler('entityCreating', function(entity)
    if entity ~= nil and DoesEntityExist(entity) then
        local found, doors = false, {}
        for k, v in pairs(SV_Config.Vehicles) do
            if GetHashKey(k) == GetEntityModel(entity) then
                found, doors = true, v.doors
            end
        end
        if found then
            local netid = NetworkGetNetworkIdFromEntity(entity)
            TriggerClientEvent('mh-rptrunks:client:CreateVehicleTarget', -1, netid, doors)
        end
    end
end)