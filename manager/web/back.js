$("body").hide();
$(".container-logado").hide() ;


var username = "";
var password = "";


window.addEventListener("message", function (event) {
  let possui = event.data.tem;

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
  
  if (possui){
    $(".container-logado").show();
    $(".container-notlogado").hide();
  } else{
    $(".container-notlogado").show();
    $(".container-logado").hide();

  }

  $(".login").click(function() {
    var username = $("#username").val();
    var password = $("#password").val();
    
    if(username){
      if(password){
        $.post("http://manager/logarconta", JSON.stringify({ username: username, senha: password}));
      }
    }
  });
  $(".create").click(function(){
    var username = $("#username").val();
    var password = $("#password").val();
    
    
    $.post("http://manager/criarconta",JSON.stringify({username: username, senha: password}))  
      
  });

});



