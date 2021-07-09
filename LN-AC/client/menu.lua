-- Locales
LN_AC.IsAdmin = false -- DON'T TOUCH THIS
local isusingfuncs = false
local isnoclipping = false
local noclipspeed = 1
local isnoclippingveh = false
local noclipveh = 1
local Players = {}

-- Thread

Citizen.CreateThread(function()
    Citizen.Wait(2500)
    TriggerServerEvent('SBmQ5ucMg4WGbpPHoSTl')
    Citizen.Wait(7500)
    while LN_AC.IsAdmin do
        Citizen.Wait(0)
        if isusingfuncs then
            if isnoclipping then
                local _ped = PlayerPedId()
                local _pcoords = GetEntityCoords(_ped)
                local _x = _pcoords.x
                local _y = _pcoords.y
                local _z = _pcoords.z
                local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
                local pitch = GetGameplayCamRelativePitch()
                local x = -math.sin(heading*math.pi/180.0)
                local y = math.cos(heading*math.pi/180.0)
                local z = math.sin(pitch*math.pi/180.0)
                local len = math.sqrt(x*x+y*y+z*z)
                if len ~= 0 then
                  x = x/len
                  y = y/len
                  z = z/len
                end
                local _camx = x
                local _camy = y
                local _camz = z
                if IsControlPressed(0, 32) then
                    _x = _x + noclipspeed * _camx
                    _y = _y + noclipspeed * _camy
                    _z = _z + noclipspeed * _camz
                elseif IsControlPressed(0, 33) then
                    _x = _x - noclipspeed * _camx
                    _y = _y - noclipspeed * _camy
                    _z = _z - noclipspeed * _camz
                end
                SetEntityVisible(_ped, false)
                SetEntityVelocity(_ped, 0.05,  0.05,  0.05)
                SetEntityCoordsNoOffset(_ped, _x, _y, _z, true, true, true) 
            end
            if isnoclippingveh then
                local _ped = GetVehiclePedIsIn(PlayerPedId(), false)
                local _pcoords = GetEntityCoords(_ped)
                local _x = _pcoords.x
                local _y = _pcoords.y
                local _z = _pcoords.z
                local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
                local pitch = GetGameplayCamRelativePitch()
                local x = -math.sin(heading*math.pi/180.0)
                local y = math.cos(heading*math.pi/180.0)
                local z = math.sin(pitch*math.pi/180.0)
                local len = math.sqrt(x*x+y*y+z*z)
                if len ~= 0 then
                  x = x/len
                  y = y/len
                  z = z/len
                end
                local _camx = x
                local _camy = y
                local _camz = z
                if IsControlPressed(0, 32) then
                    _x = _x + noclipveh * _camx
                    _y = _y + noclipveh * _camy
                    _z = _z + noclipveh * _camz
                elseif IsControlPressed(0, 33) then
                    _x = _x - noclipveh * _camx
                    _y = _y - noclipveh * _camy
                    _z = _z - noclipveh * _camz
                end
                SetEntityVisible(_ped, false)
                SetEntityVelocity(_ped, 0.05,  0.05,  0.05)
                SetEntityCoordsNoOffset(_ped, _x, _y, _z, true, true, true) 
            end
        end
    end
end)
-- MENU 2
local menu2 = MenuV:CreateMenu(false, "LnLeaks-Admin  Tools", 'centerright', 255, 0, 0, 'size-125', 'example', 'LnLeaks', 'LnLeaks: Admin Menu')
local menu2_noclip = menu2:AddCheckbox({ icon = '🐦', label = 'NoClip', description = 'Activate/Deactivate NoClip', value = 'n' })
local menu2_range = menu2:AddRange({ icon = '💨', label = 'NoClip speed', description = 'Set Noclip Speed', min = 0, max = 10, value = 0, saveOnUpdate = true })
local menu2_godmode = menu2:AddCheckbox({ icon = '🔱', label = 'GodMode', description = 'Activate/Deactivate GodMode',value = 'n' })
local menu2_invisible = menu2:AddCheckbox({ icon = '👻', description = 'Invisible', label = 'Invisible', value = 'n' })
local menu2_suicide = menu2:AddButton({ icon = '⚰️', description = 'Suicide', label = 'Suicide' })
local menu2_revive = menu2:AddButton({ icon = '🌈️', description = 'Revive jezelf', label = 'Revive' })
local menu2_healplayer = menu2:AddButton({ icon = '✨', description = 'Heal', label = 'Heal' })
local menu2_givearmor = menu2:AddButton({ icon = '🛡️', description = 'Give Armor', label = 'Give Armor' })
local menu2_giveallweapons = menu2:AddButton({ icon = '🔫', description = 'Give All Weapons', label = 'Give All Weapons' })
local menu2_removeallweapons = menu2:AddButton({ icon = '❌', description = 'Remove All Weapons ', label = 'Remove All Weapons' })
local menu2_showcoords = menu2:AddButton({ icon = '🎯', description = 'Print Player Coords (F8)', label = 'Print Coords (F8)' })
menu2_noclip:On('check', function(item)
    isusingfuncs = true
    isnoclipping = true
end)
menu2_noclip:On('uncheck', function(item)
    isusingfuncs = false
    isnoclipping = false
    SetEntityVisible(PlayerPedId(), true)
end)
menu2_range:On('change', function(item, newValue, oldValue)
    noclipspeed = newValue
end)
menu2_godmode:On('check', function(item)
    SetEntityInvincible(PlayerPedId(), true)
end)
menu2_godmode:On('uncheck', function(item)
    SetEntityInvincible(PlayerPedId(), false)
end)
menu2_invisible:On('check', function(item)
    SetEntityVisible(PlayerPedId(), false)
end)
menu2_invisible:On('uncheck', function(item)
    SetEntityVisible(PlayerPedId(), true)
end)
menu2_suicide:On('select', function(item)
    SetEntityHealth(PlayerPedId(), 0)
end)
menu2_revive:On('select', function(item)
    TriggerEvent('esx_ambulancejob:revive') -- Change trigger if needed
end)
menu2_healplayer:On('select', function(item)
    local _ped = PlayerPedId()
    SetEntityHealth(_ped, 200)
    ClearPedBloodDamage(_ped)
    ResetPedVisibleDamage(_ped)
    ClearPedLastWeaponDamage(_ped)
end)
menu2_givearmor:On('select', function(item)
    SetPedArmour(PlayerPedId(), 100)
end)
local weapons = {"WEAPON_UNARMED", "WEAPON_KNIFE", "WEAPON_KNUCKLE", "WEAPON_NIGHTSTICK", "WEAPON_HAMMER", "WEAPON_BAT", "WEAPON_GOLFCLUB", "WEAPON_CROWBAR", "WEAPON_BOTTLE", "WEAPON_DAGGER", "WEAPON_HATCHET", "WEAPON_MACHETE", "WEAPON_FLASHLIGHT", "WEAPON_SWITCHBLADE", "WEAPON_PISTOL", "WEAPON_PISTOL_MK2", "WEAPON_COMBATPISTOL", "WEAPON_APPISTOL", "WEAPON_PISTOL50", "WEAPON_SNSPISTOL", "WEAPON_HEAVYPISTOL", "WEAPON_VINTAGEPISTOL", "WEAPON_STUNGUN", "WEAPON_FLAREGUN", "WEAPON_MARKSMANPISTOL", "WEAPON_REVOLVER", "WEAPON_MICROSMG", "WEAPON_SMG", "WEAPON_MINISMG", "WEAPON_SMG_MK2", "WEAPON_ASSAULTSMG", "WEAPON_MG", "WEAPON_COMBATMG", "WEAPON_COMBATMG_MK2", "WEAPON_COMBATPDW", "WEAPON_GUSENBERG", "WEAPON_RAYPISTOL", "WEAPON_MACHINEPISTOL", "WEAPON_ASSAULTRIFLE", "WEAPON_ASSAULTRIFLE_MK2", "WEAPON_CARBINERIFLE", "WEAPON_CARBINERIFLE_MK2", "WEAPON_ADVANCEDRIFLE", "WEAPON_SPECIALCARBINE", "WEAPON_BULLPUPRIFLE", "WEAPON_COMPACTRIFLE", "WEAPON_PUMPSHOTGUN", "WEAPON_SAWNOFFSHOTGUN", "WEAPON_BULLPUPSHOTGUN", "WEAPON_ASSAULTSHOTGUN", "WEAPON_MUSKET", "WEAPON_HEAVYSHOTGUN", "WEAPON_DBSHOTGUN", "WEAPON_SNIPERRIFLE", "WEAPON_HEAVYSNIPER", "WEAPON_HEAVYSNIPER_MK2", "WEAPON_MARKSMANRIFLE", "WEAPON_GRENADELAUNCHER", "WEAPON_GRENADELAUNCHER_SMOKE", "WEAPON_RPG", "WEAPON_STINGER", "WEAPON_FIREWORK", "WEAPON_HOMINGLAUNCHER", "WEAPON_GRENADE", "WEAPON_STICKYBOMB", "WEAPON_PROXMINE", "WEAPON_MINIGUN", "WEAPON_RAILGUN", "WEAPON_POOLCUE", "WEAPON_BZGAS", "WEAPON_SMOKEGRENADE", "WEAPON_MOLOTOV", "WEAPON_FIREEXTINGUISHER", "WEAPON_PETROLCAN", "WEAPON_SNOWBALL", "WEAPON_FLARE", "WEAPON_BALL"}
menu2_giveallweapons:On('select', function(item)
    for _, weapon in pairs(weapons) do
        local _whash = GetHashKey(weapon)
        GiveWeaponToPed(PlayerPedId(), _whash, 3000)
    end
end)
menu2_removeallweapons:On('select', function(item)
    for _, weapon in pairs(weapons) do
        local _whash = GetHashKey(weapon)
        RemoveWeaponFromPed(PlayerPedId(), _whash)
    end
end)

menu2_showcoords:On('select', function(item)
    local _coords = GetEntityCoords(PlayerPedId())
    print(_coords)
end)

-- MENU 3
local menu3 = MenuV:CreateMenu(false, "LnLeaks: Geconnected Spelers", 'centerright', 255, 0, 0, 'size-125', 'example', 'menuv', 'LN-AC: Connected Players')
menu3:On('open', function(m)
    m:ClearItems()
    TriggerServerEvent('tBtysfoC96Vx4JK8p3pW')
    Citizen.Wait(500)
    for k,v in pairs(Players) do
        local player = menu3:AddButton({label = v.name, value = v.name, description = "Server ID: "..v.id})
    end
end)

RegisterNetEvent("ppskINSwjmAXyHcpLLp")
AddEventHandler("ppskINSwjmAXyHcpLLp", function(playerlist)
    Players = playerlist
end)

-- MENU 4
local menu4 = MenuV:CreateMenu(false, "LnLeaks Server Tools", 'centerright', 255, 0, 0, 'size-125', 'example', 'menuv', 'LN-AC: Server Tools')
local menu4_deletevehicles = menu4:AddButton({ icon = '🚙', label = 'DV ALLE AUTOS', description = 'Do a carwipe', value = menu4_deletevehicles })
local menu4_deleteprops = menu4:AddButton({ icon = '🏢', label = 'VERWIJDER ALLE PROPS', value = deleteprops, description = 'Do this if there is a hacker' })
local menu4_deletepeds = menu4:AddButton({ icon = '🧍', label = 'Delete All Peds', value = menu4_deletepeds, description = 'Do this if there is a hacker' })
menu4_deletevehicles:On('select', function(item)
    TriggerServerEvent('cq1PxSiVi0iCw0maULS3')
end)

menu4_deleteprops:On('select', function(item)
    TriggerServerEvent('xsc8yaDNYGoCMvAWogff')
end)

menu4_deletepeds:On('select', function(item)
    TriggerServerEvent('m0QCCVqpGuCSLNBc60Tc')
end)

-- MENU 5
local menu5 = MenuV:CreateMenu(false, "LnLeaks Teleport  Options", 'centerright', 255, 0, 0, 'size-125', 'example', 'menuv', 'LN-AC: Teleport Options')
local menu5_tptowaypoint = menu5:AddButton({ icon = '📍', label = 'TP to your waypoint', description = 'TP To Waypoint' })
menu5_tptowaypoint:On('select', function(item) -- Thanks to Qalle (ESX_Marker for this :) (https://github.com/qalle-git/esx_marker)
    local _waypoint = GetFirstBlipInfoId(8)

    if DoesBlipExist(_waypoint) then
        local waypointCoords = GetBlipInfoIdCoord(_waypoint)

        for height = 1, 1000 do
            SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

            local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

            if foundGround then
                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
                break
            end

            Citizen.Wait(5)
        end
    end
end)

-- MENU 6
local menu6 = MenuV:CreateMenu(false, "LnLeaks Vehicle Tools", 'centerright', 255, 0, 0, 'size-125', 'example', 'menuv', 'LN-AC: Vehicle Tools')
local menu6_fixcar = menu6:AddButton({ icon = '🔧', label = 'Fix Je auto', description = 'Repair your vehicle' })
local menu6_godmode = menu6:AddCheckbox({ icon = '🔱', label = 'GodMode', description = 'GodMode', value = 'n' })
local menu6_noclip = menu6:AddCheckbox({ icon = '🐦', label = 'NoClip (Vehicle)', description = 'Noclip With vehicle', value = 'n' })
local menu6_nocliprange = menu6:AddRange({ icon = '💨', label = 'Noclip Speed', min = 0, max = 10, value = 0, saveOnUpdate = true, description = 'change noclip Speed' })
local menu6_engineboost = menu6:AddRange({ icon = '👩‍🦼', label = 'Engine Boost', min = 0, max = 10, value = 0, saveOnUpdate = true, description = 'Set Vehicle Engine Boost' })
menu6_fixcar:On('select', function(item)
    local _ped = PlayerPedId()
    local _vehiclein = GetVehiclePedIsIn(_ped)
    SetVehicleFixed(_vehiclein)
    SetVehicleDeformationFixed(_vehiclein)
    SetVehicleUndriveable(_vehiclein, false)
    SetVehicleEngineOn(_vehiclein, true, true)
end)
menu6_godmode:On('check', function(item)
    local _ped = PlayerPedId()
    local _vehiclein = GetVehiclePedIsIn(_ped)
    SetEntityInvinicible(_vehiclein, true)
end)
menu6_godmode:On('uncheck', function(item)
    local _ped = PlayerPedId()
    local _vehiclein = GetVehiclePedIsIn(_ped)
    SetEntityInvinicible(_vehiclein, false)
end)
menu6_noclip:On('check', function(item)
    isusingfuncs = true
    isnoclippingveh = true
end)
menu6_noclip:On('uncheck', function(item)
    isusingfuncs = false
    isnoclippingveh = false
    SetEntityVisible(PlayerPedId(), true)
    local _vehiclein = GetVehiclePedIsIn(PlayerPedId())
    SetEntityVisible(_vehiclein, true)
end)
menu6_nocliprange:On('change', function(item, newValue, oldValue)
    noclipveh = newValue
end)
menu6_engineboost:On('change', function(item, newValue, oldValue)
    local _veh = GetVehiclePedIsIn(PlayerPedId())
    local _boost = 1.0
    if newValue ~= 1 then
        _boost = newValue * 50.0
    end 
    SetVehicleEnginePowerMultiplier(_veh, _boost)
end)

-- MENU 7
local menu7 = MenuV:CreateMenu(false, "LnLeaks Admin Tools", 'centerright', 255, 0, 0, 'size-125', 'example', 'menuv', 'LN-AC: TP Tools Tools')
local menu7_acinfo = menu7:AddButton({ icon = 'ℹ️', label = 'AC/Admin Menu', description = 'dsc.gg/lnleaks' })
local menu7_creatorac = menu7:AddButton({ icon = 'ℹ️', label = 'By Ryga', description = 'dsc.gg/lnleaks' })

-- NEW MENUS (Augusto/Mopped7)

-- Menu 8 (Skin do PED)
local menu8 = MenuV:CreateMenu(false, "CHANGE SKIN", 'centerright', 255, 0, 0, 'size-125', 'example', 'menuv', 'Change Characters skin')
local menu8_padraom = menu8:AddButton({ icon = '👨', label = 'MANNELIJK NORMAAL', description = 'Verander je terug in je manelijke normale vorm' })
local menu8_padraof = menu8:AddButton({ icon = '👧', label = 'VROUWELIJK NORMAAL', description = 'Verander je terug in je vrouwelijke normale vorm' })
local menu8_monkey = menu8:AddButton({ icon = '🐒', label = 'AAP', description = 'Veranderd je in een aap' })
local menu8_rato = menu8:AddButton({ icon = '🐀 ', label = 'Rat', description = 'Veranderd je in een Rat' })
local menu8_dog = menu8:AddButton({ icon = '🐶 ', label = 'Hond', description = 'Veranderd je in een hond' })
local menu8_cat = menu8:AddButton({ icon = '🐱 ', label = 'Kat', description = 'Veranderd je in een kat' })
local menu8_ped1 = menu8:AddButton({ icon = '🚶 ', label = 'NPC Man', description = 'Veranderd je in een NPC MAN' })
local menu8_ped2 = menu8:AddButton({ icon = '💃 ', label = 'NPC VROUW', description = 'Veranderd je in een NPC VROUW' })
menu8_padraom:On('select', function(item)
    local modelo = GetHashKey('mp_m_freemode_01')
    while not HasModelLoaded(modelo) do
        RequestModel(modelo)
        Citizen.Wait(10)
    end

    if HasModelLoaded(modelo) then
        SetPlayerModel(PlayerId(),modelo)
        SetModelAsNoLongerNeeded(modelo)
    end
end)

menu8_padraof:On('select', function(item)
    local modelo = GetHashKey('mp_f_freemode_01')
    while not HasModelLoaded(modelo) do
        RequestModel(modelo)
        Citizen.Wait(10)
    end

    if HasModelLoaded(modelo) then
        SetPlayerModel(PlayerId(),modelo)
        SetModelAsNoLongerNeeded(modelo)
    end
end)

menu8_monkey:On('select', function(item)
    local modelo = GetHashKey('a_c_chimp')
    while not HasModelLoaded(modelo) do
        RequestModel(modelo)
        Citizen.Wait(10)
    end

    if HasModelLoaded(modelo) then
        SetPlayerModel(PlayerId(),modelo)
        SetModelAsNoLongerNeeded(modelo)
    end
end)

menu8_rato:On('select', function(item)
    local modelo = GetHashKey('a_c_rat')
    while not HasModelLoaded(modelo) do
        RequestModel(modelo)
        Citizen.Wait(10)
    end

    if HasModelLoaded(modelo) then
        SetPlayerModel(PlayerId(),modelo)
        SetModelAsNoLongerNeeded(modelo)
    end
end)

menu8_dog:On('select', function(item)
    local modelo = GetHashKey('a_c_poodle')
    while not HasModelLoaded(modelo) do
        RequestModel(modelo)
        Citizen.Wait(10)
    end

    if HasModelLoaded(modelo) then
        SetPlayerModel(PlayerId(),modelo)
        SetModelAsNoLongerNeeded(modelo)
    end
end)

menu8_cat:On('select', function(item)
    local modelo = GetHashKey('a_c_cat_01')
    while not HasModelLoaded(modelo) do
        RequestModel(modelo)
        Citizen.Wait(10)
    end

    if HasModelLoaded(modelo) then
        SetPlayerModel(PlayerId(),modelo)
        SetModelAsNoLongerNeeded(modelo)
    end
end)

menu8_ped1:On('select', function(item)
    local modelo = GetHashKey('a_m_m_fatlatin_01')
    while not HasModelLoaded(modelo) do
        RequestModel(modelo)
        Citizen.Wait(10)
    end

    if HasModelLoaded(modelo) then
        SetPlayerModel(PlayerId(),modelo)
        SetModelAsNoLongerNeeded(modelo)
    end
end)

menu8_ped2:On('select', function(item)
    local modelo = GetHashKey('a_f_m_fatcult_01')
    while not HasModelLoaded(modelo) do
        RequestModel(modelo)
        Citizen.Wait(10)
    end

    if HasModelLoaded(modelo) then
        SetPlayerModel(PlayerId(),modelo)
        SetModelAsNoLongerNeeded(modelo)
    end
end)

-- Menu 9

local menu9 = MenuV:CreateMenu(false, "Zie Functions", 'centerright', 255, 0, 0, 'size-125', 'example', 'menuv', 'Activate/Deactivate Vision Functions')
local menu9_visaonoturna = menu9:AddCheckbox({ icon = '🌒', label = 'Night Vision', description = 'Activate/Deactivate Night Vision', value = 'n' })
local menu9_visaotermica = menu9:AddCheckbox({ icon = '🔥', label = 'Thermal Vision', description = 'Activate/deactivate Thermal Vision', value = 'n' })

menu9_visaonoturna:On('check', function(item)
    SetNightvision(1)
end)
menu9_visaonoturna:On('uncheck', function(item)
    SetNightvision(0)
end)

menu9_visaotermica:On('check', function(item)
    SetSeethrough(1)
end)
menu9_visaotermica:On('uncheck', function(item)
    SetSeethrough(0)
end)

-- PRINCIPAL MENU
local menu = MenuV:CreateMenu(false, "lnleaks", 'centerright', 255, 0, 0, 'size-125', 'example', 'menuv', 'LN-AC: Main Menu')
local menu_admintools = menu:AddButton({ icon = '🔰', label = 'Admin Tools', value = menu2, description = 'Open the admin opties' })
local menu_connectedplayers = menu:AddButton({ icon = '⛹️', label = 'Connected Players', value = menu3, description = 'Bekijk de spelers lijst' })
local menu_servertools = menu:AddButton({ icon = '🤖', label = 'SERVER TOOLS', value = menu4, description = 'Open Server Tools' })
local menu_tpoptions = menu:AddButton({ icon = '📍', label = 'TPM', value = menu5, description = 'Open Teleport Options' })
local menu_skin = menu:AddButton({ icon = '🦺', label = 'Skin Change', value = menu8, description = 'Change Your skin' })
local menu_visaoconfig = menu:AddButton({ icon = '🔭', label = 'Vision Opties', value = menu9, description = 'Activate/Deactivate Vision Mods' })
local menu_vehicleoptions = menu:AddButton({ icon = '🚗', label = 'Vehicle Options', value = menu6, description = 'Open vehicle options' })
local menu_infoanticheat = menu:AddButton({ icon = 'ℹ️', label = 'Information', value = menu7, description = 'Watch the ac version' })

RegisterCommand('lnacmenu', function()
    if LN_AC.IsAdmin then
        menu:Open()
    end
end, false)

RegisterKeyMapping('lnacmenu', "LN-AC Admin Menu", 'keyboard', 'INSERT')
