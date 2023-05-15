ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent("Tikoz:PESJNonWl")
AddEventHandler("Tikoz:PESJNonWl", function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.setJob(job, 0)
end)

RegisterServerEvent("Tikoz:CandidaturePoleEmploi")
AddEventHandler("Tikoz:CandidaturePoleEmploi", function(name, job, num, motiv, web)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    PerformHttpRequest(web, function(err, text, headers) end, 'POST', json.encode({username = "Candidature", content = "``CANDIDATURE``\nNom et prénom : "..name.."\nNuméro : "..num.."\nLettre de motivation : "..motiv}), { ['Content-Type'] = 'application/json' })
    MySQL.Async.execute("INSERT INTO tikoz_poleemploi (identifier, name, job, num, motiv) VALUES (@identifier, @name, @job, @num, @motiv)",
    {["@identifier"] = xPlayer.getIdentifier(), ["@name"] = name, ["@job"] = job, ["@num"] = num, ["@motiv"] = motiv})
end)

RegisterServerEvent("Tikoz/delcandid")
AddEventHandler("Tikoz/delcandid", function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.execute("DELETE FROM tikoz_poleemploi WHERE id = ?",
    {id})
end)

ESX.RegisterServerCallback('Tikoz/getcandid', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local list = {}

    MySQL.Async.fetchAll('SELECT * FROM tikoz_poleemploi', {
    }, function(result)
        for i=1, #result, 1 do
            table.insert(list, {
                id = result[i].id,
                identifier = result[i].identifier,
                job = result[i].job,
                name = result[i].name,
                num = result[i].num,
                motiv = result[i].motiv,
            })
        end
        cb(list, xPlayer.getIdentifier())
    end)
end)


------------------------- Raffineur ----------------------------


RegisterNetEvent('Tikoz:PERAFIRecoltefuel')
AddEventHandler('Tikoz:PERAFIRecoltefuel', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local iteminventaire = xPlayer.getInventoryItem("petrole").count

    if iteminventaire >= 50 then
        TriggerClientEvent('esx:showNotification', source, "Tu ne peux pas récolté plus de ~b~50 litres~s~ de ~b~pétrole")
        recoltefuel = false
    else
        xPlayer.addInventoryItem("petrole", 1)
        TriggerClientEvent('esx:showNotification', source, "Vous récolté du ~b~pétrole")
		return
    end
end)

RegisterNetEvent('Tikoz:PERAFITraitementfuel')
AddEventHandler('Tikoz:PERAFITraitementfuel', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local iteminventaire = xPlayer.getInventoryItem("essence").count
    local petrolnb = xPlayer.getInventoryItem("petrole").count

    if iteminventaire >= 50 then
        TriggerClientEvent('esx:showNotification', source, "Vous ne pouvez pas récolté plus de ~b~50 litres d'essence")
        traitefuel = false
    elseif petrolnb > 1 then

        xPlayer.removeInventoryItem("petrole", 2)
        xPlayer.addInventoryItem("essence", 1)
        TriggerClientEvent('esx:showNotification', source, "Vous traitez le ~b~pétrole")
	    return
 
    elseif petrolnb < 1 then
        TriggerClientEvent('esx:showNotification', source, "Vous avez pas assez de ~b~pétrole ")
    end
end)

RegisterNetEvent('Tikoz:PERAFIVendrefuel')
AddEventHandler('Tikoz:PERAFIVendrefuel', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local petrolnb = xPlayer.getInventoryItem("essence").count
    local payej = math.random(5, 10)
    if petrolnb == 0 then
        TriggerClientEvent('esx:showNotification', source, "Vous ne pouvez plus vendre ~b~d'essence")
        ventefuel = false
    else
        xPlayer.addMoney(payej)
        xPlayer.removeInventoryItem("essence", 1)
        TriggerClientEvent('esx:showNotification', source, "Vous avez gagné : ~g~"..payej..'$')
	    return
    end
end)

------------------------- Jardinier ----------------------------

RegisterNetEvent('Tikoz:JardinierJob')
AddEventHandler('Tikoz:JardinierJob', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local paye = math.random(Config.Jardinier.PayeMin, Config.Jardinier.PayeMax)
    xPlayer.addAccountMoney('bank', paye)
    TriggerClientEvent('esx:showNotification', source, "Vous avez gagné : ~g~"..paye..'$')
end)

------------------------- EBOUEUR ----------------------------

RegisterNetEvent('Tikoz/EboueurPaye')
AddEventHandler('Tikoz/EboueurPaye', function(payemin, payemax)
    local xPlayer = ESX.GetPlayerFromId(source)
    local payej = math.random(payemin, payemax)
    xPlayer.addAccountMoney('bank', payej)
    TriggerClientEvent('esx:showNotification', source, "Vous avez gagné : ~g~"..payej..'$')
end)
