SetupTraficant = function(data) {
    $(".traficant-list").html("");

    if (data.length > 0) {
        $.each(data, function(i, traficant){
            var element = '<div class="traficants-list" id="traficantid-'+i+'"> <div class="traficants-list-firstletter">' + (traficant.name).charAt(0).toUpperCase() + '</div> <div class="traficants-list-fullname">' + traficant.name + '</div> <div class="traficants-list-call"><i class="fas fa-phone"></i></div> </div>'
            $(".traficant-list").append(element);
            $("#traficantid-"+i).data('traficantData', traficant);
        });
    } else {
        var element = '<div class="traficants-list"><div class="no-traficant">Nu sunt traficanti disponibili.</div></div>'
        $(".traficants-list").append(element);
    }
}

$(document).on('click', '.traficant-list-call', function(e){
    e.preventDefault();

    var traficantData = $(this).parent().data('traficantData');
    
    var cData = {
        number: traficantData.phone,
        name: traficantData.name
    }

    $.post('http://phone/CallContact', JSON.stringify({
        ContactData: cData,
        Anonymous: KR.Phone.Data.AnonymousCall,
    }), function(status){
        if (cData.number !== KR.Phone.Data.PlayerData.phone) {
            if (status.IsOnline) {
                if (status.CanCall) {
                    if (!status.InCall) {
                        if (KR.Phone.Data.AnonymousCall) {
                            KR.Phone.Notifications.Add("fas fa-phone", "Phone", "Ai inceput un apel cu numar privat!");
                        }
                        $(".phone-call-outgoing").css({"display":"block"});
                        $(".phone-call-incoming").css({"display":"none"});
                        $(".phone-call-ongoing").css({"display":"none"});
                        $(".phone-call-outgoing-caller").html(cData.name);
                        KR.Phone.Functions.HeaderTextColor("white", 400);
                        KR.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
                        setTimeout(function(){
                            $(".traficant-app").css({"display":"none"});
                            KR.Phone.Animations.TopSlideDown('.phone-application-container', 400, 0);
                            KR.Phone.Functions.ToggleApp("phone-call", "block");
                        }, 450);
    
                        CallData.name = cData.name;
                        CallData.number = cData.number;
                    
                        KR.Phone.Data.currentApplication = "phone-call";
                    } else {
                        KR.Phone.Notifications.Add("fas fa-phone", "Phone", "Esti deja ocupat!");
                    }
                } else {
                    KR.Phone.Notifications.Add("fas fa-phone", "Phone", "Acesta persoana vorbeste!");
                }
            } else {
                KR.Phone.Notifications.Add("fas fa-phone", "Phone", "Acesta persoana nu vorbeste!");
            }
        } else {
            KR.Phone.Notifications.Add("fas fa-phone", "Phone", "Nu iti poti apela propriul numar!");
        }
    });
});