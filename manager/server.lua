Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

func = {}
Tunnel.bindInterface(GetCurrentResourceName(),func)

Config = module(GetCurrentResourceName(),"config/config")


vRP.prepare("vRP/create_acc_manager","INSERT INTO account_manager(username,id,senha,groups) VALUES(@username,@user_id,@senha,@groups)")
vRP.prepare("vRP/get_acc","SELECT * FROM account_manager WHERE id = @user_id")
vRP.prepare("vRP/set_bank","INSERT INTO bank_manager(id,bank) VALUES(@user_id,@bank)")
vRP.prepare("vRP/get_bank","SELECT * FROM bank_manager WHERE id = @user_id")
vRP._prepare("vRP/up_bank","UPDATE bank_manager SET bank = @bank WHERE id = @user_id")

--[[RegisterServerEvent("saldobank")
AddEventHandler("saldobank", function()
    local src = source
    local user_id = vRP.getUserId(src)
    local conta = vRP.query("vRP/get_acc", {user_id = user_id})
    local bank = vRP.query("vRP/get_bank", {user_id = user_id})
    --local qntd = tonumber(quantidade)

    if user_id then
        if #conta > 0 then
            if conta[1].id == user_id then
                if #bank > 0 then
                    if bank[1].id == user_id then
                        local saldo = 
                    end   
                end   
            end
        end
    end

end)]]--

function func.getsaldo()
    local src = source
    local user_id = vRP.getUserId(src)
    local conta = vRP.query("vRP/get_acc", {user_id = user_id})
    local bank = vRP.query("vRP/get_bank", {user_id = user_id})
    


    if user_id then
        if #conta > 0 then
            if conta[1].id == user_id then
                if #bank > 0 then
                    if bank[1].id == user_id then
                        local saldo = bank[1].bank
                        --print("Saldo obtido "..parseInt(saldo))
                        return saldo
                        
                    end   
                end   
            end
        end
    end
end

func.deposit = function(quantidade)
    local src = source
    local user_id = vRP.getUserId(src)
    local conta = vRP.query("vRP/get_acc", {user_id = user_id})
    local bank = vRP.query("vRP/get_bank", {user_id = user_id})
    local qntd = tonumber(quantidade)

    if #conta > 0 then
        if conta[1].id == user_id then
            if qntd >= 1 then
                if #bank > 0 then
                    if bank[1].id == user_id then -- vRP.giveMoney(user_id,parseInt(price))
                       if Config.DinheiroMao == true then
                            if vRP.tryPayment(user_id,parseInt(qntd)) then
                                local quantidadeold = bank[1].bank
                                local qntotal = quantidadeold + qntd
                                vRP.execute("vRP/up_bank", {bank = qntotal, user_id = user_id})
                            end
                        elseif Config.DinheiroMao == false then
                            if vRP.tryFullPayment(user_id,parseInt(qntd)) then
                                local quantidadeold = bank[1].bank
                                local qntotal = quantidadeold + qntd
                                vRP.execute("vRP/up_bank", {bank = qntotal, user_id = user_id})
                            end
                       end
                    --else
                        --vRP.execute("vRP/set_bank",{user_id = user_id ,bank = qntd})
                    end
                else
                    if Config.DinheiroMao == true then
                        if vRP.tryPayment(user_id,parseInt(qntd)) then
                            vRP.execute("vRP/set_bank",{user_id = user_id ,bank = qntd})
                        end
                    elseif Config.DinheiroMao == false then
                        if vRP.tryFullPayment(user_id,parseInt(qntd)) then
                            vRP.execute("vRP/set_bank",{user_id = user_id ,bank = qntd})
                        end
                   end
                end
            end
        end
    else
        print("Nenhuma conta encontrada")
    end
    --
end

func.loginacc = function(username,senha)
    local src = source
    local user_id = vRP.getUserId(src)
    local conta = vRP.query("vRP/get_acc",{user_id = user_id})
    --local bank = vRP.query("vRP/get_bank",{bank = })

    if user_id then
        if #conta > 0 then
            if conta[1].id == user_id then -- ou troca pra if #conta > 0 then
                if username == conta[1].username then
                    if senha == conta[1].senha then
                        TriggerClientEvent("Notify",source,"negado","Conta Criada",10000)
                        --TriggerClientEvent('logado',src)
                        TriggerClientEvent('logado',src)
                    else
                        TriggerClientEvent("Notify",source,"negado","Senha errada",10000)
                        print("Senha Incorreta")
                    end
                else 
                    TriggerClientEvent("Notify",source,"negado","Username errado",10000)
                    print("Username Incorreto")
                end
            else
                TriggerClientEvent("Notify",source,"negado","Crie uma conta!.",10000)
                print("Voçê não possui conta!")
                
            end
        else
            --TriggerClientEvent("Notify",source,"negado","registre uma conta.",10000) 
            print("Nenhuma conta no banco de dados")
        end
    end

end

func.createcc = function(username,senha)
    local src = source
    local user_id = vRP.getUserId(src)
    local groups = vRP.getUserGroups(user_id)
    local conta = vRP.query("vRP/get_acc",{ user_id = user_id })

    if user_id then
        if #conta > 0 then
            if conta[1].id == user_id then -- ou troca pra if #conta > 0 then
                --TriggerClientEvent("Notify",source,"negado","Já possui uma conta!.",10000)
                print("Já possui uma conta criada!")
            end
        else
            if Config.GroupName == true then -- groups["manager"]
                print("Criando")
                vRP.execute("vRP/create_acc_manager",{username = username , user_id = user_id , senha = senha, groups = "manager"})
            else
                print("Você não tem permissão.")
                TriggerClientEvent("Notify",source,"negado","Você não tem permissão.",10000)
            end
        end
    end

end

print("^3Script^2 created by ^1Raavy#0001^0")
print("^5Qualquer bug me chame!^0")

-- TriggerClientEvent("Notify",source,"negado","Você tem multas pendentes.",10000)

