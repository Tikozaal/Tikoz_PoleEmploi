ESX = exports["es_extended"]:getSharedObject()

local Tikozaal = {}
local PlayerData = {}

vestiairerafi = {
    Base = {Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 251, 255}, Title = "Vestiaire"},
    Data = { currentMenu = "Menu :"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, result)

            if btn.name == "Tenu de travail" then
                TRaffineur()
                CloseMenu()
            elseif btn.name == "Tenu civil" then
                Tcivil()
                CloseMenu()
            end
        end,
},
    Menu = {
        ["Menu :"] = {
            b = {
                {name = "Tenu de travail", ask = "", askX = true},
                {name = "Tenu civil", ask = "", askX = true},
            }
        }
    }
}

Citizen.CreateThread(function()

    while true do 
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local menu = Config.Raffineur.Vestiaire
        local dist = #(pos - menu)

        if dist <= 2 and ESX.PlayerData.job.name == "raffineur" then

            ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour ouvrir le ~b~menu")
            DrawMarker(6, menu, nil, nil, nil, -90, nil, nil, 0.7, 0.7, 0.7, 0, 251, 255, 200, false, true, 2, false, false, false, false)

            if IsControlJustPressed(1, 51) then
                CreateMenu(vestiairerafi)
            end

        else
            Citizen.Wait(1000)
        end
        Citizen.Wait(0)
    end
end)

function TRaffineur()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = Config.TenueRaffineur.Homme
        else
            uniformObject = Config.TenueRaffineur.Femme
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)end

function Tcivil()
ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
TriggerEvent('skinchanger:loadSkin', skin)
end)
end