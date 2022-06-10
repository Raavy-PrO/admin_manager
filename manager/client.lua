Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")

func = Tunnel.getInterface(GetCurrentResourceName())

local senha
onNUI = false

RegisterNUICallback("criarconta", function(data)
    senha = data.senha
    username = data.username
    
    func.createcc(username,senha)
end)

RegisterNUICallback("logarconta", function(data)
    username = data.username
    senha = data.senha    

    func.loginacc(username,senha)
end)

RegisterNUICallback("fechar",function(data)
    
end)

RegisterNetEvent('jatem')
AddEventHandler('jatem',function()

    --tem = false
    --if tem == false then
	    SendNUIMessage({tem = true})
    --end
end)

RegisterCommand("teste", function()
    onNUI = not onNUI
    if onNUI then
        SetNuiFocus(true, true)
        SendNUIMessage({mostre = true})
    else
        SetNuiFocus(false)
        SendNUIMessage({mostre = false})
    end
end)