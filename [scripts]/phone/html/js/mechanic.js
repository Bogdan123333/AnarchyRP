SetupMechanic = function(data) {
    $(".mechanic-list").html("");

    if (data.length > 0) {
        $.each(data, function(i, mechanics){
            var element = '<div class="mechanics-list" id="mechanicsid-'+i+'"> <div class="mechanics-list-firstletter">' + (mechanics.name).charAt(0).toUpperCase() + '</div> <div class="mechanics-list-fullname">' + mechanics.name + '</div> <div class="mechanics-list-call"><i class="fas fa-phone"></i></div> </div>'
            $(".mechanic-list").append(element);
            $("#mechanicsid-"+i).data('mechanicsData', mechanics);
        });
    } else {
        var element = '<div class="mechanics-list"><div class="no-mechanic">Nu sunt mecanici disponibili.</div></div>'
        $(".mechanic-list").append(element);
    }
}




$(document).on('click', '.mechanics-list-call', function(e){
    e.preventDefault();

    var mechanicsData = $(this).parent().data('mechanicsData');
    
    var cData = {
        number: mechanicsData.phone,
        name: mechanicsData.name
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
                            KR.Phone.Notifications.Add("fas fa-phone", "Phone", "Ai inceput un apel cu numar privat");
                        }
                        $(".phone-call-outgoing").css({"display":"block"});
                        $(".phone-call-incoming").css({"display":"none"});
                        $(".phone-call-ongoing").css({"display":"none"});
                        $(".phone-call-outgoing-caller").html(cData.name);
                        KR.Phone.Functions.HeaderTextColor("white", 400);
                        KR.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
                        setTimeout(function(){
                            $(".mechanic-app").css({"display":"none"});
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
                KR.Phone.Notifications.Add("fas fa-phone", "Phone", "Acesta persoana nu este disponibila!");
            }
        } else {
            KR.Phone.Notifications.Add("fas fa-phone", "Phone", "Nu puteti apela propriul numar!");
        }
    });
});