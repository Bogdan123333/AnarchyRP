$(document).ready(function() {
    window.addEventListener('message', function(event) {
        var data = event.data;
        switch (data.action) {
            case "setValue":
                if (data.divId || data.divId != "") {
                    let info = document.getElementById(data.divId);
                    if (info || info != null) {

                        info.innerHTML = data.value
                    }
                }
                break;
                case 'updateOnlinePlayers':
                    document.getElementById("online").innerHTML = data.players
            break;
            }
    });
})

window.addEventListener("message", function(event) {
    let data = event.data
    if (data.action == "setSafeZone") {
        if(data.display){
            $(".safezone").fadeIn();
        } else {
            $(".safezone").fadeOut();
        }
    }

    if (data.action == "setStaff"){
        $(".tickets").fadeIn();
    }
    
    
    if (data.action == "sendAdminAnn"){
        document.querySelector(".adminName").innerHTML = data.name+" ["+data.uid+"]";
        document.querySelector(".adminMess").innerHTML = data.mes;
        document.getElementById("adminAnn").style.display = "block";
        setTimeout(function(){
            $(".adminAnn").fadeOut();
        }, 8000);
    }
})

    window.addEventListener("load",function(){
        this.setInterval(function () {
            const d = new Date();
            var hh = String(d.getHours()).padStart(2, '0');
            var mmm = String(d.getMinutes()).padStart(2, '0');
    
            time = hh + ':' + mmm
            this["document"]["getElementById"]("info-ora")["innerHTML"] = time;
        }, 10000);
    })

    window.addEventListener("message",function(event){
        var data = event.data 
        if (data.type == "togglehud"){
            $(".hudbani").fadeIn().delay(5000).fadeOut();
        }
    })