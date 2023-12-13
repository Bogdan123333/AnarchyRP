SetupDoctor = function(data) {
    $(".doctor2-list").html("");

    if (data.length > 0) {
        $.each(data, function(i, doctor){
            var element = '<div class="doctor-list" id="doctorid-'+i+'"> <div class="doctor-list-firstletter">' + (doctor.name).charAt(0).toUpperCase() + '</div> <div class="doctor-list-fullname">' + doctor.name + '</div> <div class="doctor-list-call"><i class="fas fa-phone"></i></div> </div>'
            $(".doctor2-list").append(element);
            $("#doctorid-"+i).data('doctorData', doctor);
        });
    } else {
        var element = '<div class="doctor-list"><div class="no-doctor">Nu sunt medici la datorie..</div></div>'
        $(".doctor2-list").append(element);
    }
}

$(document).on('click', '.doctor-list-call', function(e){
    e.preventDefault();

    var doctorData = $(this).parent().data('doctorData');
    
    var cData = {
        number: doctorData.phone,
        name: doctorData.name
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
                            KR.Phone.Notifications.Add("fas fa-phone", "Phone", "You started a secret search!");
                        }
                        $(".phone-call-outgoing").css({"display":"block"});
                        $(".phone-call-incoming").css({"display":"none"});
                        $(".phone-call-ongoing").css({"display":"none"});
                        $(".phone-call-outgoing-caller").html(cData.name);
                        KR.Phone.Functions.HeaderTextColor("white", 400);
                        KR.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
                        setTimeout(function(){
                            $(".doctor-app").css({"display":"none"});
                            KR.Phone.Animations.TopSlideDown('.phone-application-container', 400, 0);
                            KR.Phone.Functions.ToggleApp("phone-call", "block");
                        }, 450);
    
                        CallData.name = cData.name;
                        CallData.number = cData.number;
                    
                        KR.Phone.Data.currentApplication = "phone-call";
                    } else {
                        KR.Phone.Notifications.Add("fas fa-phone", "Phone", "You are busy!");
                    }
                } else {
                    KR.Phone.Notifications.Add("fas fa-phone", "Phone", "The number you are calling is busy!");
                }
            } else {
                KR.Phone.Notifications.Add("fas fa-phone", "Phone", "The person's phone is off!");
            }
        } else {
            KR.Phone.Notifications.Add("fas fa-phone", "Phone", "You can't call your number..");
        }
    });
});
