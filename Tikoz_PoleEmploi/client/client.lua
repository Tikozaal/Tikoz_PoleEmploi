ESX = exports["es_extended"]:getSharedObject()

local Tikozaal = {}
local PlayerData = {}
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

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

menupole = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 251, 255}, Title = "Pôle Emploi"},
    Data = { currentMenu = "Menu :"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, result)

            if btn.name == "Intérim" then
                menupole.Menu["Intérim"].b = {} 
                for i=1, #ListeNonWl, 1 do
                    table.insert(menupole.Menu["Intérim"].b, { name = ListeNonWl[i].name, ask = "", askX = true})
                end
                OpenMenu("Intérim")
            elseif btn.name == "Métier WL" then
                menupole.Menu["Métier WL"].b = {}
                for i=1, #ListeWl, 1 do 
                    table.insert(menupole.Menu["Métier WL"].b, { name = ListeWl[i].name , ask = "", askX = true})
                end
                OpenMenu("Métier WL")
            end

            for i=1, #ListeNonWl, 1 do
                if btn.name == ListeNonWl[i].name then
                    ESX.ShowNotification(ListeNonWl[i].Message)
                    local job = ListeNonWl[i].job
                    TriggerServerEvent('Tikoz:PESJNonWl', job)
                end
            end
            
            for i=1, #ListeWl, 1 do 
                if btn.name == ListeWl[i].name then
                    name = ListeWl[i].name
                    web = ListeWl[i].webhook
                    job = ListeWl[i].job
                    ESX.ShowNotification(ListeWl[i].Message)
                    if Config.Candidature == true then
                        OpenMenu("Candidature")
                    end
                end
            end

            if btn.name == "Faire une candidature" then
                canask = false
                ESX.TriggerServerCallback("Tikoz/getcandid", function(list, iden) 
                    for k,v in pairs(list) do 
                        if iden == v.identifier and job == v.job then canask = true end
                    end
                    if canask then
                        ESX.ShowNotification("~r~Vous avez déjà postuler pour rejoindre l'entreprise : "..name)
                    else
                        np = Keyboardput("Quel est votre nom et prénom ?", "", 40)
                        numero = Keyboardput("Quel est votre numéro ? ", "", 15)
                        motiv = Keyboardput('Lettre de motivation ', "", 96)
                    
                        if np == nil then
                            ESX.ShowAdvancedNotification('Pole emploi', "~b~Information", "~r~Nom et prénom invalide", 'CHAR_BANK_FLEECA', 9)
                            return
                        else
                            if numero == nil then
                                ESX.ShowAdvancedNotification('Pole emploi', "~b~Information", "~r~Numéro de téléphone invalide", 'CHAR_BANK_FLEECA', 9)
                                return
                            else
                                if motiv == nil then
                                    ESX.ShowAdvancedNotification('Pole emploi', "~b~Information", "~r~Lettre de motivation invalide", 'CHAR_BANK_FLEECA', 9)
                                    return
                                else
                                    TriggerServerEvent("Tikoz:CandidaturePoleEmploi", np, job, tonumber(numero), motiv, tostring(web))
                                    return
                                end
                            end
                        end
                    end
                end)
            end

            
        end,
},
    Menu = {
        ["Menu :"] = {
            b = {
                {name = "Intérim", ask = ">", askX = true},
                {name = "Métier WL", ask = ">", askX = true},
            }
        },
        ["Intérim"] = {
            b = {
            }
        },
        ["Métier WL"] = {
            b = {
            }
        },
        ["Candidature"] = {
            b = {
                {name = "Faire une candidature", ask = "", askX = true},
            }
        },
        ["Résumé"] = {
            b = {
            }
        },
    }
}


CreateThread(function()
    local pi = "a_f_m_bevhills_01"
    local po = GetHashKey(pi)
    RequestModel(po)
    while not HasModelLoaded(po) do Wait(0) end
    local pipo = CreatePed(6, po, Config.Pos.Ped, true, false)
    FreezeEntityPosition(pipo, true)
    SetEntityInvincible(pipo, true)
    SetBlockingOfNonTemporaryEvents(pipo, true)
 
    while true do 
        wait = 0
        if #(GetEntityCoords(PlayerPedId()) - Config.Pos.Menu) <= 2 then
            ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour ouvrir le ~b~menu")
            DrawMarker(6, Config.Pos.Menu, nil, nil, nil, -90, nil, nil, 0.7, 0.7, 0.7, 0, 251, 255, 200, false, true, 2, false, false, false, false)

            if IsControlJustPressed(1, 51) then
                CreateMenu(menupole)
            end
        else
            wait = 1000
        end
        Wait(wait)
    end
end)

local function jbsel(self, _, btn, PMenu, menuData, result)
    ESX.TriggerServerCallback("Tikoz/getcandid", function(list) 
        for k,v in pairs(list) do 
            if (btn.name == v.name) then
                menujb.Menu["Détails"].b = {}
                table.insert(menujb.Menu["Détails"].b, {name = "Nom et prénom", ask = "~b~"..v.name, askX = true})
                table.insert(menujb.Menu["Détails"].b, {name = "Numéro :", ask = "~y~"..v.num, askX = true})
                table.insert(menujb.Menu["Détails"].b, {name = "Lettre de motivation :", ask = "...", askX = true, Description = v.motiv})
                table.insert(menujb.Menu["Détails"].b, {name = "~r~Supprimer la candidature", ask = "", askX = true, id = v.id})
                OpenMenu("Détails")
            end
        end

        if (btn.name == "~r~Supprimer la candidature") then
            TriggerServerEvent("Tikoz/delcandid", btn.id) CloseMenu()
        end 
    end)
end 

menujb = {}
menujb.Base = {Header = {"commonmenu","interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 215,255}, Title = "Candidature"}
menujb.Data = {currentMenu = "Menu :"}
menujb.Events = {onSelected = jbsel}
menujb.Menu = {
    ["Menu :"] = {
        b = {
        }
    },
    ["Détails"] = {
        b = {
        }
    }
}

CreateThread(function()
    while true do 
        wait = 0
        if posjob() then
            if IsControlJustPressed(1,51) then
                menujb.Menu["Menu :"].b = {}
                ESX.TriggerServerCallback("Tikoz/getcandid", function(list) 
                    for k, v in pairs(list) do   
                        if v.job == ESX.PlayerData.job.name then
                            table.insert(menujb.Menu["Menu :"].b, {name = v.name, ask = "~b~"..v.num, askX = true})
                        end
                    end
                    CreateMenu(menujb)
                end)
            end
        else
            wait = 1000
        end
        Wait(wait)
    end
end)

function posjob()
    for k,v in pairs(MenuJobPos) do 
        if #(GetEntityCoords(PlayerPedId()) - vector3(v.x, v.y, v.z)) <= 2 and ESX.PlayerData.job.name == v.job and ESX.PlayerData.job.grade >= v.grade then 
            ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour ouvrir le ~b~menu")

            return true
        end
    end
end

CreateThread(function()
    for k, v in pairs(Blipjob) do 
        local blip = AddBlipForCoord(v.pos)
        SetBlipSprite (blip, v.id)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, v.Taille)
        SetBlipColour (blip, v.Couleur)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.name)
        EndTextCommandSetBlipName(blip)
    end

    pebli = AddBlipForCoord(Config.Pole.Pos.x, Config.Pole.Pos.y)
    SetBlipSprite (pebli, Config.Pole.Id)
    SetBlipDisplay(pebli, 4)
    SetBlipScale(pebli, Config.Pole.Taille)
    SetBlipColour (pebli, Config.Pole.Couleur)
    SetBlipAsShortRange(pebli, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Pole.Nom)
    EndTextCommandSetBlipName(pebli)
end)