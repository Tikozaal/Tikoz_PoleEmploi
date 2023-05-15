ESX = exports["es_extended"]:getSharedObject()

local Tikozaal = {}
local PlayerData = {}

vestiairejardi = {
    Base = {Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 251, 255}, Title = "Jardinier"},
    Data = { currentMenu = "Vestiaire :"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, result)

            if btn.name == "Tenu de travail" then
                TJardinier()
                CloseMenu()
            elseif btn.name == "Tenu civil" then
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                    TriggerEvent('skinchanger:loadSkin', skin)
                end)
                CloseMenu()
            end
        end,
},
    Menu = {
        ["Vestiaire :"] = {
            b = {
                {name = "Tenu de travail", ask = "", askX = true},
                {name = "Tenu civil", ask = "", askX = true},
            }
        }
    }
}

CreateThread(function()

    while true do 
        if #(GetEntityCoords(PlayerPedId()) - Config.Jardinier.Vestiaire) <= 2 and ESX.PlayerData.job.name == "jardinier" then

            ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour ouvrir le ~b~menu")
            DrawMarker(6, menu, nil, nil, nil, -90, nil, nil, 0.7, 0.7, 0.7, 0, 251, 255, 200, false, true, 2, false, false, false, false)

            if IsControlJustPressed(1, 51) then
                CreateMenu(vestiairejardi)
            end

        else
            Wait(1000)
        end
        Wait(0)
    end
end)

function TJardinier()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = Config.TenueJardinier.Homme
        else
            uniformObject = Config.TenueJardinier.Femme
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)
end

