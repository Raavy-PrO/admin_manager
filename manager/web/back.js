$("body").hide();
$(".section-logado").hide();
$(".listapp").hide();
//$("#inpute").hide();


var username = "";
var password = "";
var quantidade = 0;
let teste = "teste";
let open = false;


window.addEventListener("message", function (event) {
  if(event.data.tem != undefined){
    
  }

  if (event.data.saldo != undefined){
    let saldo = event.data.saldo;
    
    $(".bankinfo").text("R$:"+saldo)
  }else{
    $(".bankinfo").text("R$:0")
  }
  //possui = true
  //console.log(event.data.mostre)


  if (event.data.mostre != undefined) {
    let states = event.data.mostre;
    
    

    if (states) {
      $("body").show();
    } else {
      $("body").hide();
    }
    if (states.hide) {
      sendData("fechar2", "fechar2");
    }
  }
  
  if (event.data.logado){
    $(".section-logado").show();
    $(".section-login").hide();
    console.log("logado back")

  }if(event.data.logado == false){
    $(".section-login").show();
    $(".section-logado").hide();
    console.log("Não logado")

  }

  $(".login").click(function() {
    login()
   //console.log("click em Logar")

  });
  $(".create").click(function(){
   register()
   //console.log("click em register")
  });

  $("#send").click(function(){
    depositar();
  });

  $(".titulo").click(function(){
    fechar();
  })
 

});

let criado = false


$("#banco").click(function(){
  ababank();
  /*if (criado == false){
    createRow();
    $("#send").show();
    criado = true
  }else{
    alert("Criado já");
  }*/
})

function register(){
  var username = $("#username").val();
  var password = $("#password").val();
  
  if(username != ""){
    if(password != ""){
      $.post("http://manager/criarconta",JSON.stringify({username: username, senha: password}));
    }
  }

  

}  

function login(){
  var username = $("#username").val();
  var password = $("#password").val();
  
  if(username != ""){
    if(password != ""){
      $.post("http://manager/logarconta", JSON.stringify({ username: username, senha: password}));
    }
  }
}



function createRow(){
  $(".listapp").append('<li class="teste" id='+teste+'>Digite o valor:<input type="text" name="banco" id="qnt" /></li>');
};

function depositar(){
  if($("#qnt").val() == ""){
    //print("Digite um Quantidade")
    
  }else{
    quantidade = $("#qnt").val();
    if(quantidade == undefined){
      // caso valor seja indefinido
    }else{
      $.post("http://manager/setbalance",JSON.stringify({quantidade: quantidade}));
      //console.log("Enviando dot "+ quantidade)
    } 
    
  }
}

function fechar(){
  $.post("http://manager/fechar",JSON.stringify({fechar: false}));
}

function ababank(){
  
  if(open == false){
    open = true
    $(".listapp").show()
  }else{
    open = false
    $(".listapp").hide()
  }
}


