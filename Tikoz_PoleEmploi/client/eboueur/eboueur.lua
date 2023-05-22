ESX = exports["es_extended"]:getSharedObject()

openmenu = false

menueboueur = {
    Base = {Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 251, 255}, Title = "Eboueur"},
    Data = {currentMenu = "Menu :"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, result)

            if btn.name == "Commencez à travailler" then
                CloseMenu()
                openmenu = true
                start_mission()
            end
            
        end,
},
    Menu = {
        ["Menu :"] = {
            b = {
                {name = "Commencez à travailler", ask = "", askX = true},
            }
        }
    }
}

function start_mission()
    CreateThread(function()

        local pi = Config.Eboueur.Vehicule
        local po = GetHashKey(pi)
        RequestModel(po)
        while not HasModelLoaded(po) do Wait(0) end
        pipo = CreateVehicle(po, Config.Eboueur.SpawnVehicule, true, false)
        TaskWarpPedIntoVehicle(PlayerPedId(), pipo, -1)
        SetVehRadioStation(pipo, "OFF")

        findstrash(pipo, true)

        while true do 
            if #(GetEntityCoords(PlayerPedId()) - Config.Eboueur.DelVehicule) <= 2 then

                ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour rangé le ~b~véhicule")

                if IsControlJustPressed(1,51) then
                    openmenu = false
                    findstrash(pipo, false)
                    DeleteVehicle(pipo)
                    ESX.ShowNotification("Vous avez rangé le ~b~véhicule")
                    return start_mission
                end

            else
                Wait(1000)
            end
            Wait(0)
        end
    end)
end

function findstrash(pipo, canwork)
    CreateThread(function()
        if canwork then
            local po = GetHashKey("prop_ld_rub_binbag_01")
            RequestModel(po)
            while not HasModelLoaded(po) do Wait(0) end
            
            local postrash = PositionPoubelle[math.random(1, #PositionPoubelle)]
            local postrash = vector3(postrash.x, postrash.y, postrash.z)
            trash = CreateObject(po, postrash, true, false, true)
            blip = AddBlipForEntity(trash)
            SetBlipSprite (blip, Config.BlipPoubelle.Id)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, Config.BlipPoubelle.Taille)
            SetBlipColour (blip, Config.BlipPoubelle.Couleur)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.BlipPoubelle.Nom)
            EndTextCommandSetBlipName(blip)
            FreezeEntityPosition(trash, true)
            SetNewWaypoint(postrash.x, postrash.y)
            wait = 0
            msg = true
            while true do 
                if not IsPedInAnyVehicle(PlayerPedId(), false) then
                    if #(GetEntityCoords(PlayerPedId()) - postrash) <= 2 then
                        wait = 0
                        if msg then
                            ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour ramasser les ~b~poubelles")
                        end
                        if IsControlJustPressed(1,51) then

                            TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
                            Wait(2000)
                            ClearPedTasksImmediately(PlayerPedId())
                            AttachEntityToEntity(trash, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0x188E), 0.3, 0.0, 0.0, 50.0, -50.0, -70.0, true, true, false, true, 1, true)
                            msg = false
                            jettrash(trash, pipo)
                            return findstrash
                        end
                    else
                        wait = 1000
                    end
                end
                Wait(wait)
            end
        else
            DeleteObject(trash)
        end
    end)
end

function jettrash(trash, pipo)
    CreateThread(function()
        wait = 0
        msg = true
        while true do 
            wait = 0

            if #(GetEntityCoords(PlayerPedId()) - GetWorldPositionOfEntityBone(pipo, GetEntityBoneIndexByName(pipo, "boot"))) <= 3 then
                if msg == true then
                    ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour jeter les ~b~poubelles")
                end
                if IsControlJustPressed(1,51) then
                    
                    SetVehicleDoorOpen(pipo, 5, true, true)
                    Wait(2000)
                    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
                    Wait(2000)
                    ClearPedTasksImmediately(PlayerPedId())
                    DeleteObject(trash)
                    SetVehicleDoorShut(pipo, 5, true, true)
                    msg = false
                    TriggerServerEvent("Tikoz/EboueurPaye", Config.Eboueur.PayeMin, Config.Eboueur.PayeMax)
                    findstrash(pipo, true)
                    return jettrash
                end
            else
                wait = 1000
            end
            Wait(wait)
        end
    end)
end

CreateThread(function()

    local pi = "s_m_m_gardener_01"
    local po = GetHashKey(pi) 
    RequestModel(po)
    while not HasModelLoaded(po) do Wait(0) end
    local pipo = CreatePed(6, po, Config.Eboueur.Ped, true, false)
    FreezeEntityPosition(pipo, true)
    SetEntityInvincible(pipo, true)
    SetBlockingOfNonTemporaryEvents(pipo, true)
    wait = 0

    while true do 
        wait = 0
        if #(GetEntityCoords(PlayerPedId()) - Config.Eboueur.Menu) <= 2 and ESX.PlayerData.job.name == "eboueur" then

            ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour ouvrir le ~b~menu")
            DrawMarker(6, Config.Eboueur.Menu, nil, nil, nil, -90, nil, nil, 0.7, 0.7, 0.7, 0, 251, 255, 200, false, true, 2, false, false, false, false)

            if IsControlJustPressed(1,51) and not openmenu then
                CreateMenu(menueboueur)
            end
        else
            wait = 1000
        end
        Wait(wait)
    end
end)
