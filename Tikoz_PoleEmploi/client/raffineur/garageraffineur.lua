
ESX = exports["es_extended"]:getSharedObject()

local Tikozaal = {}
local PlayerData = {}


garagerafi = {
    Base = { Header = {"commonmenu" ,"interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 251, 255}, Title = "Garage"},
    Data = { currentMenu = "Menu :"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, result)

            if btn.name == "Sortir le camion" then
                local ped = PlayerPedId()
                local pos = GetEntityCoords(ped)

                local pa = "tanker"
                local pe = GetHashKey(pa)
                RequestModel(pe)
                while not HasModelLoaded(pe) do Wait(0) end
                local pepa = CreateVehicle(pe, 2685.8, 1604.66, 23.59, 5.63, true, false)

                local pi = "packer"
                local po = GetHashKey(pi)
                RequestModel(po)
                while not HasModelLoaded(po) do Wait(0) end
                local pipo = CreateVehicle(po, Config.Raffineur.SpawnCar, true, false)
                TaskWarpPedIntoVehicle(ped, pipo, -1)

                CreateThread(function()
                
                    while true do 

                        if #(GetEntityCoords(PlayerPedId()) - Config.Raffineur.DelCar) <= 2 and ESX.PlayerData.job.name == "raffineur" then

                            ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour rangé le ~b~véhicule")
                            DrawMarker(6, Config.Raffineur.DelCar, nil, nil, nil, -90, nil, nil, 0.7, 0.7, 0.7, 0, 251, 255, 200, false, true, 2, false, false, false, false)

                            if IsControlJustPressed(1, 51) then

                                DeleteVehicle(pipo)
                                DeleteVehicle(pepa)
                                return
                            end

                        else
                            Wait(1000)
                        end

                        Wait(0)
                    end

                end)
                CloseMenu()
            end
        end,
},
    Menu = {
        ["Menu :"] = {
            b = {
                {name = "Sortir le camion", ask = "", askX = true},
            }
        }
    }
}

CreateThread(function()
    while true do 
        if #(GetEntityCoords(PlayerPedId()) - Config.Raffineur.Garage) <= 2 and ESX.PlayerData.job.name == "raffineur" then
            wait = 0 
            ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour ouvrir le ~b~menu")
            DrawMarker(6, Config.Raffineur.Garage, nil, nil, nil, -90, nil, nil, 0.7, 0.7, 0.7, 0, 251, 255, 200, false, true, 2, false, false, false, false)
            if IsControlJustPressed(1, 51) then
                CreateMenu(garagerafi)
            end
        else
            wait = 1000
        end
        Wait(wait)
    end
end)
