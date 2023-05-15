ESX = exports["es_extended"]:getSharedObject()

local Tikozaal = {}
local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
end)


function Keyboardput(TextEntry, ExampleText, MaxStringLength) 
    AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
    blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end



menuraffineur = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 251, 255}, Title = "Raffineur"},
    Data = { currentMenu = "Menu :"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, result)

            if btn.name == "Position" then
                OpenMenu("Position")
            elseif btn.name == "Fermé" then
                CloseMenu()
            end

            if btn.name == "Position ~b~récolte" then
                SetNewWaypoint(Config.Raffineur.Recolte)
            elseif btn.name == "Position ~b~traitement" then
                SetNewWaypoint(Config.Raffineur.Traitement)
            elseif btn.name == "Position ~b~vente" then
                SetNewWaypoint(Config.Raffineur.Vente)
            end
        end,
},
    Menu = {
        ["Menu :"] = {
            b = {
                {name = "Position", ask = ">", askX = true},
                {name = "Fermé", ask = "", askX = true},
            }
        },
        ["Position"] = {
            b = {
                {name = "Position ~b~récolte", ask = "", askX = true},
                {name = "Position ~b~traitement", ask = "", askX = true},
                {name = "Position ~b~vente", ask = "", askX = true},
                
            }
        },
    }
}

keyRegister("Raffineur", "Menu F6", "F6", function()
    if ESX.PlayerData.job.name == "raffineur" then
        CreateMenu(menuraffineur)
    end
end)


recolterafi = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 251, 255}, Title = "Raffineur"},
    Data = { currentMenu = "Récolte fuel"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, result)

            if btn.name == "Commencé à récolté" then
                StartRecoltefuel()
            end
        end,
},
    Menu = {
        ["Récolte fuel"] = {
            b = {
                {name = "Commencé à récolté", ask = "", askX = true},
            }
        }
    }
}

Citizen.CreateThread(function()

    while true do 

        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local menu = Config.Raffineur.Recolte
        local dist = #(pos - menu)

        if dist <= 5 and ESX.PlayerData.job.name == "raffineur" then
            
            ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour ouvrir le ~b~menu")
            DrawMarker(6, menu, nil, nil, nil, -90, nil, nil, 9.0, 9.0, 9.0, 0, 251, 255, 200, false, true, 2, false, false, false, false)

            if IsControlJustPressed(1, 51) then
                CreateMenu(recolterafi)
            end

        else
            StopRecolteFuel()
            Citizen.Wait(1000)
        end
        Citizen.Wait(0)
    end
end)

function StopRecolteFuel()
    if recoltefuel then
    	recoltefuel = false
    end
end

function StartRecoltefuel()
    if not recoltefuel then
        recoltefuel = true
    while recoltefuel do
        Citizen.Wait(2000)
        TriggerServerEvent('Tikoz:PERAFIRecoltefuel')
    end
    else
        recoltefuel = false
    end
end

traitementrafi = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 251, 255}, Title = "Raffineur"},
    Data = { currentMenu = "Traitement pétrole :"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, result)

            if btn.name == "Commencé le traitement" then
                StartTraitementfuel()
                CloseMenu()
            end
        end,
},
    Menu = {
        ["Traitement pétrole :"] = {
            b = {
                {name = "Commencé le traitement", ask = "", askX = true},
            }
        }
    }
}

function StopTraitementFuel()
    if traitefuel then
    	traitefuel = false
    end
end

function StartTraitementfuel()
    if not traitefuel then
        traitefuel = true
    while traitefuel do
        Citizen.Wait(2000)
        TriggerServerEvent('Tikoz:PERAFITraitementfuel')
    end
    else
        traitefuel = false
    end
end

Citizen.CreateThread(function()

    while true do 

        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local menu = Config.Raffineur.Traitement
        local dist = #(pos - menu)

        if dist <= 5 and ESX.PlayerData.job.name == "raffineur" then
                
            ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour ouvrir le ~b~menu")
            DrawMarker(6, menu, nil, nil, nil, -90, nil, nil, 9.0, 9.0, 9.0, 0, 251, 255, 200, false, true, 2, false, false, false, false)

            if IsControlJustPressed(1, 51) then
                CreateMenu(traitementrafi)
            end

        else
            StopTraitementFuel()
            Citizen.Wait(1000)
        end

        Citizen.Wait(0)
    end
end)


venterafi = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 251, 255}, Title = "Raffineur"},
    Data = { currentMenu = "Vente d'essence"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, result)
            
            if btn.name == "Commencer à vendre" then
                StartVenteFuel()
                CloseMenu()
            end
        end,

},
    Menu = {
        ["Vente d'essence"] = {
            b = {
                {name = "Commencer à vendre", ask = "", askX = true},
            }
        }
    }
}

function StopVenteFuel()
    if ventefuel then
    	ventefuel = false
    end
end

function StartVenteFuel()
    if not ventefuel then
        ventefuel = true
    while ventefuel do
        Citizen.Wait(2000)
        TriggerServerEvent('Tikoz:PERAFIVendrefuel')
    end
    else
        ventefuel = false
    end
end

Citizen.CreateThread(function()

    while true do 
        
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local menu = Config.Raffineur.Vente
        local dist = #(pos - menu)

        if dist <= 5 and ESX.PlayerData.job.name == "raffineur" then

            ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour ouvrir le ~b~menu")
            DrawMarker(6, menu, nil, nil, nil, -90, nil, nil, 9.0, 9.0, 9.0, 0, 251, 255, 200, false, true, 2, false, false, false, false)

            if IsControlJustPressed(1, 51) then
                CreateMenu(venterafi)
            end

        else
            StopVenteFuel()
            Citizen.Wait(1000)
        end

        Citizen.Wait(0)
    end
end)

