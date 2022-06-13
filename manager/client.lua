Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")

func = Tunnel.getInterface(GetCurrentResourceName())

local senha
local logado = false
local saldo
onNUI = false

RegisterCommand("teste", function()
    onNUI = not onNUI
    if onNUI then
        SetNuiFocus(true, true)
        SendNUIMessage({mostre = true})
    else
        SetNuiFocus(false)
        SendNUIMessage({mostre = false})
        print("Fechar")
    end
end)


RegisterNUICallback("setbalance", function(data)

    quantidade = data.quantidade
    func.deposit(data.quantidade)

end)

RegisterNUICallback("fechar", function(data)

    onNUI = data.fechar
    SetNuiFocus(false)
    SendNUIMessage({mostre = false})
    

end)

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


RegisterNetEvent('logado')
AddEventHandler('logado',function()

	SendNUIMessage({logado = true})
    print("logado")
    
end)

Citizen.CreateThread(
	function()
        while true do
            local saldo = func.getsaldo()
            SendNUIMessage({saldo = saldo})
            --print(saldo)
            Citizen.Wait(1000)
        end
    end
)