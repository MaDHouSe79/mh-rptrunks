--[[ ===================================================== ]] --
--[[             MH RP Trunks Script by MaDHouSe           ]] --
--[[ ===================================================== ]] --
local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('mh-rptrunks:server:refreshConfig')
AddEventHandler('mh-rptrunks:server:refreshConfig', function()
    local src = source
    TriggerClientEvent('mh-rptrunks:client:sendConfig', src, SV_Config.Vehicles)
end)

RegisterNetEvent('entityCreating')
AddEventHandler('entityCreating', function(entity)
    if entity ~= nil and DoesEntityExist(entity) then
        local netid = NetworkGetNetworkIdFromEntity(entity)
        local found, doors = false, nil
        for k, v in pairs(SV_Config.Vehicles) do
            if GetHashKey(k) == GetEntityModel(entity) then found, doors = true, v.doors end
        end
        if found then TriggerClientEvent('mh-rptrunks:client:CreateVehicleTarget', -1, netid, doors) end
    end
end)
