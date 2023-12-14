SetupDrivers = function(data) {
    $(".driver-list").html("");

    if (data.length > 0) {
        $.each(data, function(i, taxi){
            var element = '<div class="taxi-list" id="taxiid-'+i+'"> <div class="taxi-list-firstletter">' + (taxi.name).charAt(0).toUpperCase() + '</div> <div class="taxi-list-fullname">' + taxi.name + '</div> <div class="taxi-list-call"><i class="fas fa-phone"></i></div> </div>'
            $(".driver-list").append(element);
            $("#taxiid-"+i).data('taxiData', taxi);
        });
    } else {
        var element = '<div class="taxi-list"><div class="no-driver">Nu sunt taximetristi disponibili!</div></div>'
        $(".driver-list").append(element);
    }
}

$(document).on('click', '.taxi-list-call', function(e){
    e.preventDefault();

    var taxiData = $(this).parent().data('taxiData');
    
    var cData = {
        number: taxiData.phone,
        name: taxiData.name
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
                            $(".taxi-app").css({"display":"none"});
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
                    KR.Phone.Notifications.Add("fas fa-phone", "Phone", "Acest numar este deja ocupat!");
                }
            } else {
                KR.Phone.Notifications.Add("fas fa-phone", "Phone", "Acesta persoana nu este disponibila!");
            }
        } else {
            KR.Phone.Notifications.Add("fas fa-phone", "Phone", "Nu iti poti apela propriul numar..");
        }
    });
});
