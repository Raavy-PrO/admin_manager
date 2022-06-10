Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

func = {}
Tunnel.bindInterface(GetCurrentResourceName(),func)

vRP.prepare("vRP/create_acc_manager","INSERT INTO account_manager(username,id,senha,groups) VALUES(@username,@user_id,@senha,@groups)")
vRP.prepare("vRP/get_acc","SELECT * FROM account_manager WHERE id = @user_id")

func.loginacc = function(username,senha)
    local src = source
    local user_id = vRP.getUserId(src)
    local conta = vRP.query("vRP/get_acc",{user_id = user_id})

    if user_id then
        if #conta > 0 then
            if conta[1].id == user_id then -- ou troca pra if #conta > 0 then

                if username == conta[1].username then
    
                    if senha == conta[1].senha then
                        print("Logando")
                        TriggerClientEvent('jatem',src)
                    else
                        print("Senha errada")
                    end
                else 
                    print("Username errado")
                end
                
            else
                print("Crie uma conta!")
            end
        else
            print("registre uma conta")
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
                print("já tem conta")
                --Wait(10000)
                --os.exit()
            end
        else
             
            if groups["prefeitura"] == true then
                print("Criando")
                vRP.execute("vRP/create_acc_manager",{username = username , user_id = user_id , senha = senha, groups = "manager"})
            else
                print("Não tem grupo")
            end
        end
    end

end

