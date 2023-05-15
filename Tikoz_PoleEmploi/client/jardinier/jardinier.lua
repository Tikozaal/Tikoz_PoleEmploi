ESX = exports["es_extended"]:getSharedObject()
openmenu = false
function Keyboardput(TextEntry, ExampleText, MaxStringLength) 
    AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
    blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end

local function jarsel(self, _, btn, PMenu, menuData, result)
    if (btn.name == "Commencez à travailler") then
        init_jard() CloseMenu() openmenu = true
    end 
end

jar = {}
jar.Base = {Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0,215,255}, Title ="Jardinier"}
jar.Data = {currentMenu = "Menu :"}
jar.Events = {onSelected = jarsel}
jar.Menu = {
    ["Menu :"] = {
        b = {
            {name = "Commencez à travailler", ask = "", askX = true},
        }
    }
}

function init_jard()
    local h = GetHashKey(Config.Jardinier.Vehicule)
    RequestModel(h)
    while not HasModelLoaded(h) do Wait(0) end 
    car = CreateVehicle(h, Config.Jardinier.SpawnVehicule, true, false)
    TaskWarpPedIntoVehicle(PlayerPedId(), car, -1)
    SetVehRadioStation(car, "OFF")
    SetVehicleFuelLevel(car, 99.9)

    spawnplant()

    CreateThread(function()
        while true do 
            if #(GetEntityCoords(PlayerPedId()) - Config.Jardinier.DelCar) <= 5 and ESX.PlayerData.job.name == "jardinier" then
                wait = 0
                ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour ranger le ~b~véhicule")

                if IsControlJustPressed(1,51) then
                    DeleteVehicle(car) 
                    openmenu = false
                    ESX.ShowNotification("~g~Vous avez ranger le véhicule")
                    DeleteObject(plant)
                    return
                end
            else
                wait = 1000
            end
            Wait(wait)
        end
    end)
end

function spawnplant()

    local pi = "prop_plant_flower_01"
    local po = GetHashKey(pi)
    RequestModel(po)
    while not HasModelLoaded(po) do Wait(0) end
    local posfe = Posfeuille[math.random(1, #Posfeuille)]
    plant = CreateObject(po, posfe.x, posfe.y, posfe.z, true, false, false)
    
    blip = AddBlipForEntity(plant)
    SetBlipSprite (blip, Config.Blip.Id)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, Config.Blip.Taille)
    SetBlipColour (blip, Config.Blip.Couleur)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Blip.Nom)
    EndTextCommandSetBlipName(blip)

    findjar(plant)
end


function findjar(plant)
    CreateThread(function()
        while true do 
            if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(plant)) <= 5 then
                wait = 0 
                ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour ~r~enlever la mauvaise herbe")
                if IsControlJustPressed(1,51) then

                    SetBlockingOfNonTemporaryEvents(PlayerPedId(), true)
                    Wait(100)
                    RequestAnimDict("amb@world_human_gardener_plant@female@base")
                    while not HasAnimDictLoaded("amb@world_human_gardener_plant@female@base") do Wait(0) end
                    TaskPlayAnim(PlayerPedId(),"amb@world_human_gardener_plant@female@base","base_female", 1.0,-1.0, 10000, 1, 1, true, true, true)
                    Wait(10000)
                    TriggerServerEvent('Tikoz:JardinierJob')   
                    DeleteObject(plant)
                    spawnplant()
                    return findjar
                end
            else
                wait = 1000
            end
            Wait(wait)
        end
    end)
end

CreateThread(function()
    local po = GetHashKey(Config.Jardinier.Ped)
    RequestModel(po)
    while not HasModelLoaded(po) do Wait(0) end 
    pipo = CreatePed(6, po, Config.Jardinier.Pnj, true, false)
    SetEntityInvincible(pipo, true)
    FreezeEntityPosition(pipo, true)
    SetBlockingOfNonTemporaryEvents(pipo, true)
    while true do 
        if #(GetEntityCoords(PlayerPedId()) - Config.Jardinier.Menu) <= 2 and ESX.PlayerData.job.name == "jardinier" then
            wait = 0
            ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour ouvrir le ~b~menu") 
            DrawMarker(6, Config.Jardinier.Menu, nil, nil, nil, -90, nil, nil, 0.7, 0.7, 0.7, 0, 251, 255, 200, false, true, 2, false, false, false, false)
            if IsControlJustPressed(1,51) and not openmenu then
                CreateMenu(jar)
            end
        else
            wait = 1000
        end
        Wait(wait)
    end
end)