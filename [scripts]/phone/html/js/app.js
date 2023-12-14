KR = {}
KR.Phone = {}
KR.Screen = {}
KR.Phone.Functions = {}
KR.Phone.Animations = {}
KR.Phone.Notifications = {}
KR.Phone.ContactColors = {
    0: "#9b59b6",
    1: "#3498db",
    2: "#e67e22",
    3: "#e74c3c",
    4: "#1abc9c",
    5: "#9c88ff",
}

KR.Phone.Data = {
    currentApplication: null,
    PlayerData: {},
    Applications: {},
    IsOpen: false,
    CallActive: false,
    MetaData: {},
    PlayerJob: {},
    AnonymousCall: false,
}

OpenedChatData = {
    number: null,
}

var up = false
var CanOpenApp = true;

function IsAppJobBlocked(joblist, myjob) {
    var retval = false;
    if (joblist.length > 0) {
        $.each(joblist, function(i, job){
            if (job == myjob && KR.Phone.Data.PlayerData.job) {
                retval = true;
            }
        });
    }
    return retval;
}

KR.Phone.Functions.SetupApplications = function(data) {
    KR.Phone.Data.Applications = data.applications;
    $.each(data.applications, function(i, app){
        var applicationSlot = $(".phone-applications").find('[data-appslot="'+app.slot+'"]');
        var blockedapp = IsAppJobBlocked(app.blockedjobs, KR.Phone.Data.PlayerJob.name)
        $(applicationSlot).html("");
        $(applicationSlot).css({"background-color":"transparent"});
        $(applicationSlot).prop('title', "");
        $(applicationSlot).removeData('app');
        if (app.tooltipPos !== undefined) {
            $(applicationSlot).removeData('placement')
        }

        if ((!app.job || app.job === KR.Phone.Data.PlayerJob.name) && !blockedapp) {
            $(applicationSlot).css({"background-color":app.color});
            var icon = '<i class="ApplicationIcon '+app.icon+'" style="'+app.style+'"></i>';
            if (app.app == "olx") {
                icon = '<img src="./img/politie.png" class="police-icon" widtd="36" height="47">';
            }
            
            
            $(applicationSlot).html(icon+'<div class="app-unread-alerts">0</div>');
            $(applicationSlot).prop('title', app.tooltipText);
            $(applicationSlot).data('app', app.app);

            if (app.tooltipPos !== undefined) {
                $(applicationSlot).data('placement', app.tooltipPos)
            }
        }
    });

    $('[data-toggle="tooltip"]').tooltip();
}

KR.Phone.Functions.SetupAppWarnings = function(AppData) {
    $.each(AppData, function(i, app){
        var AppObject = $(".phone-applications").find("[data-appslot='"+app.slot+"']").find('.app-unread-alerts');

        if (app.Alerts > 0) {
            $(AppObject).html(app.Alerts);
            $(AppObject).css({"display":"block"});
        } else {
            $(AppObject).css({"display":"none"});
        }
    });
}

KR.Phone.Functions.IsAppHeaderAllowed = function(app) {
    var retval = true;
    $.each(Config.HeaderDisabledApps, function(i, blocked){
        if (app == blocked) {
            retval = false;
        }
    });
    return retval;
}

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: // ESCAPE
        if (up){
            $('#popup').fadeOut('slow');
            $('.popupclass').fadeOut('slow');
            $('.popupclass').html("");
            up = false
        } else {
            KR.Phone.Functions.Close();
            break;
        }
    }
});

KR.Screen.popUp = function(source){
    if(!up){
        $('#popup').fadeIn('slow');
        $('.popupclass').fadeIn('slow');
        $('<img  src='+source+' style = "width:100%; height: 100%;">').appendTo('.popupclass')
        up = true
    }
}

KR.Screen.popDown = function(){
    if(up){
        $('#popup').fadeOut('slow');
        $('.popupclass').fadeOut('slow');
        $('.popupclass').html("");
        up = false
    }
}


$(document).on('click', '.phone-application', function(e){
    e.preventDefault();
    var PressedApplication = $(this).data('app');
    var AppObject = $("."+PressedApplication+"-app");
    if (AppObject.length !== 0) {
        if (CanOpenApp) {
            if (KR.Phone.Data.currentApplication == null) {
                KR.Phone.Animations.TopSlideDown('.phone-application-container', 300, 0);
                KR.Phone.Functions.ToggleApp(PressedApplication, "block");
                
                if (KR.Phone.Functions.IsAppHeaderAllowed(PressedApplication)) {
                    KR.Phone.Functions.HeaderTextColor("black", 300);
                }
    
                KR.Phone.Data.currentApplication = PressedApplication;
    
                if (PressedApplication == "settings") {
                    $("#myPhoneNumber").text(KR.Phone.Data.PlayerData.phone)
                } else if (PressedApplication == "twitter") {
                    $.post('http://phone/GetMentionedTweets', JSON.stringify({}), function(MentionedTweets){
                        KR.Phone.Notifications.LoadMentionedTweets(MentionedTweets)
                    })
                    $.post('http://phone/GetHashtags', JSON.stringify({}), function(Hashtags){
                        KR.Phone.Notifications.LoadHashtags(Hashtags)
                    })
                    if (KR.Phone.Data.IsOpen) {
                        $.post('http://phone/GetTweets', JSON.stringify({}), function(Tweets){
                            KR.Phone.Notifications.LoadTweets(Tweets);
                        });
                    }
                } else if (PressedApplication == "bank") {
                    KR.Phone.Functions.setupBankApp();
                } else if (PressedApplication == "whatsapp") {
                    $.post('http://phone/GetWhatsappChats', JSON.stringify({}), function(chats){
                        KR.Phone.Functions.LoadWhatsappChats(chats);
                    });
                } else if (PressedApplication == "phone") {
                    $.post('http://phone/GetMissedCalls', JSON.stringify({}), function(recent){
                        KR.Phone.Functions.SetupRecentCalls(recent);
                    });
                    $.post('http://phone/GetSuggestedContacts', JSON.stringify({}), function(suggested){
                        KR.Phone.Functions.SetupSuggestedContacts(suggested);
                    });
                    $.post('http://phone/ClearGeneralAlerts', JSON.stringify({
                        app: "phone"
                    }));
                } else if (PressedApplication == "mail") {
                    $.post('http://phone/GetMails', JSON.stringify({}), function(mails){
                        KR.Phone.Functions.SetupMails(mails);
                    });
                    $.post('http://phone/ClearGeneralAlerts', JSON.stringify({
                        app: "mail"
                    }));
                } else if (PressedApplication == "advert") {
                    $.post('http://phone/LoadAdverts', JSON.stringify({}), function(Adverts){
                        KR.Phone.Functions.RefreshAdverts(Adverts);
                    })
                } else if (PressedApplication == "garage") {
                    $.post('http://phone/SetupGarageVehicles', JSON.stringify({}), function(vehicles){
                        SetupGarageVehicles(vehicles);
                    })
                } else if (PressedApplication == "darkweb") {
                    KR.Phone.Functions.HeaderTextColor("white", 300);
                    $.post('http://phone/LoadDarkwebs', JSON.stringify({}), function(Darkwebs){
                        KR.Phone.Functions.RefreshDarkwebs(Darkwebs);
                })
                } else if (PressedApplication == "crypto") {
                    $.post('http://phone/GetCryptoData', JSON.stringify({
                        crypto: "qbit",
                    }), function(CryptoData){
                        SetupCryptoData(CryptoData);
                    })

                    $.post('http://phone/GetCryptoTransactions', JSON.stringify({}), function(data){
                        RefreshCryptoTransactions(data);
                    })
                } else if (PressedApplication == "racing") {
                    $.post('http://phone/GetAvailableRaces', JSON.stringify({}), function(Races){
                        SetupRaces(Races);
                    });
                } else if (PressedApplication == "houses") {
                    $.post('http://phone/GetPlayerHouses', JSON.stringify({}), function(Houses){
                        SetupPlayerHouses(Houses);
                    });
               } else if (PressedApplication == "taxi") {
                    $.post('http://phone/GetCurrentDrivers', JSON.stringify({}), function(data){
                        SetupDrivers(data);
                    });					
                } else if (PressedApplication == "gallery") {
                    $.post('https://phone/GetGalleryData', JSON.stringify({}), function(data){
                        setUpGalleryData(data);
                    });
                }
                else if (PressedApplication == "camera") {
                    $.post('https://phone/TakePhoto', JSON.stringify({}),function(url){
                        setUpCameraApp(url)
                    })
                    KR.Phone.Functions.Close();
                }  else if (PressedApplication == "mechanic") {
                    $.post('http://phone/GetCurrentMechanic', JSON.stringify({}), function(data){
                        SetupMechanic(data);
                    });
                }  else if (PressedApplication == "doctor") {
                    $.post('http://phone/GetCurrentDoctor', JSON.stringify({}), function(data){
                        SetupDoctor(data);
                        //SetupDrivers(data);
                    });			
                } else if (PressedApplication == "polices") {
                    $.post('http://phone/GetCurrentpolices', JSON.stringify({}), function(data){
                        Setuppolices(data);
                    });	
                } else if (PressedApplication == "traficant") {
                    $.post('http://phone/GetCurrentTraficant', JSON.stringify({}), function(data){
                        SetupTraficant(data);
                    });					
                } 
            }
        }
    } else {
        KR.Phone.Notifications.Add("fas fa-exclamation-circle", "System", "Aplicatia nu este disponibila")
    }
});

$(document).on('click', '.phone-home-container', function(event){
    event.preventDefault();

    if (KR.Phone.Data.currentApplication === null) {
        KR.Phone.Functions.Close();
    } else {
        KR.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
        KR.Phone.Animations.TopSlideUp('.'+KR.Phone.Data.currentApplication+"-app", 400, -160);
        CanOpenApp = false;
        setTimeout(function(){
            KR.Phone.Functions.ToggleApp(KR.Phone.Data.currentApplication, "none");
            CanOpenApp = true;
        }, 400)
        KR.Phone.Functions.HeaderTextColor("white", 300);

        if (KR.Phone.Data.currentApplication == "whatsapp") {
            if (OpenedChatData.number !== null) {
                setTimeout(function(){
                    $(".whatsapp-chats").css({"display":"block"});
                    $(".whatsapp-chats").animate({
                        left: 0+"vh"
                    }, 1);
                    $(".whatsapp-openedchat").animate({
                        left: -30+"vh"
                    }, 1, function(){
                        $(".whatsapp-openedchat").css({"display":"none"});
                    });
                    OpenedChatPicture = null;
                    OpenedChatData.number = null;
                }, 450);
            }
        } 

        KR.Phone.Data.currentApplication = null;
    }
});

KR.Phone.Functions.Open = function(data) {
    KR.Phone.Animations.BottomSlideUp('.container', 300, 0);
    KR.Phone.Notifications.LoadTweets(data.Tweets);
    KR.Phone.Data.IsOpen = true;
}

KR.Phone.Functions.ToggleApp = function(app, show) {
    $("."+app+"-app").css({"display":show});
}

KR.Phone.Functions.Close = function() {

    if (KR.Phone.Data.currentApplication == "whatsapp") {
        setTimeout(function(){
            KR.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
            KR.Phone.Animations.TopSlideUp('.'+KR.Phone.Data.currentApplication+"-app", 400, -160);
            $(".whatsapp-app").css({"display":"none"});
            KR.Phone.Functions.HeaderTextColor("white", 300);
    
            if (OpenedChatData.number !== null) {
                setTimeout(function(){
                    $(".whatsapp-chats").css({"display":"block"});
                    $(".whatsapp-chats").animate({
                        left: 0+"vh"
                    }, 1);
                    $(".whatsapp-openedchat").animate({
                        left: -30+"vh"
                    }, 1, function(){
                        $(".whatsapp-openedchat").css({"display":"none"});
                    });
                    OpenedChatData.number = null;
                }, 450);
            }
            OpenedChatPicture = null;
            KR.Phone.Data.currentApplication = null;
        }, 500)
    } else if (KR.Phone.Data.currentApplication == "meos") {
        $(".meos-alert-new").remove();
        $(".meos-recent-alert").removeClass("noodknop");
        $(".meos-recent-alert").css({"background-color":"#004682"}); 
    }

    KR.Phone.Animations.BottomSlideDown('.container', 300, -70);
    $.post('http://phone/Close');
    KR.Phone.Data.IsOpen = false;
}

KR.Phone.Functions.HeaderTextColor = function(newColor, Timeout) {
    $(".phone-header").animate({color: newColor}, Timeout);
}

KR.Phone.Animations.BottomSlideUp = function(Object, Timeout, Percentage) {
    $(Object).css({'display':'block'}).animate({
        bottom: Percentage+"%",
    }, Timeout);
}

KR.Phone.Animations.BottomSlideDown = function(Object, Timeout, Percentage) {
    $(Object).css({'display':'block'}).animate({
        bottom: Percentage+"%",
    }, Timeout, function(){
        $(Object).css({'display':'none'});
    });
}

KR.Phone.Animations.TopSlideDown = function(Object, Timeout, Percentage) {
    $(Object).css({'display':'block'}).animate({
        top: Percentage+"%",
    }, Timeout);
}

KR.Phone.Animations.TopSlideUp = function(Object, Timeout, Percentage, cb) {
    $(Object).css({'display':'block'}).animate({
        top: Percentage+"%",
    }, Timeout, function(){
        $(Object).css({'display':'none'});
    });
}

KR.Phone.Notifications.Add = function(icon, title, text, color, timeout) {
    $.post('http://phone/HasPhone', JSON.stringify({}), function(HasPhone){
        if (HasPhone) {
            if (timeout == null && timeout == undefined) {
                timeout = 1500;
            }
            if (KR.Phone.Notifications.Timeout == undefined || KR.Phone.Notifications.Timeout == null) {
                if (color != null || color != undefined) {
                    $(".notification-icon").css({"color":color});
                    $(".notification-title").css({"color":color});
                } else if (color == "default" || color == null || color == undefined) {
                    $(".notification-icon").css({"color":"#e74c3c"});
                    $(".notification-title").css({"color":"#e74c3c"});
                }
                KR.Phone.Animations.TopSlideDown(".phone-notification-container", 200, 8);
                if (icon !== "politie") {
                    $(".notification-icon").html('<i class="'+icon+'"></i>');
                } else {
                    $(".notification-icon").html('<img src="./img/politie.png" class="police-icon-notify">');
                }
                $(".notification-title").html(title);
                $(".notification-text").html(text);
                if (KR.Phone.Notifications.Timeout !== undefined || KR.Phone.Notifications.Timeout !== null) {
                    clearTimeout(KR.Phone.Notifications.Timeout);
                }
                KR.Phone.Notifications.Timeout = setTimeout(function(){
                    KR.Phone.Animations.TopSlideUp(".phone-notification-container", 200, -8);
                    KR.Phone.Notifications.Timeout = null;
                }, timeout);
            } else {
                if (color != null || color != undefined) {
                    $(".notification-icon").css({"color":color});
                    $(".notification-title").css({"color":color});
                } else {
                    $(".notification-icon").css({"color":"#e74c3c"});
                    $(".notification-title").css({"color":"#e74c3c"});
                }
                $(".notification-icon").html('<i class="'+icon+'"></i>');
                $(".notification-title").html(title);
                $(".notification-text").html(text);
                if (KR.Phone.Notifications.Timeout !== undefined || KR.Phone.Notifications.Timeout !== null) {
                    clearTimeout(KR.Phone.Notifications.Timeout);
                }
                KR.Phone.Notifications.Timeout = setTimeout(function(){
                    KR.Phone.Animations.TopSlideUp(".phone-notification-container", 200, -8);
                    KR.Phone.Notifications.Timeout = null;
                }, timeout);
            }
        }
    });
}

KR.Phone.Functions.LoadPhoneData = function(data) {
    KR.Phone.Data.PlayerData = data.PlayerData;
    KR.Phone.Data.PlayerJob = data.PlayerJob;
    KR.Phone.Data.MetaData = data.PhoneData.MetaData;
    KR.Phone.Functions.LoadMetaData(data.PhoneData.MetaData);
    KR.Phone.Functions.LoadContacts(data.PhoneData.Contacts);
    KR.Phone.Functions.SetupApplications(data);
    //console.log("Phone succesfully loaded!");
}

KR.Phone.Functions.UpdateTime = function(data) {    
    var NewDate = new Date();
    var NewHour = NewDate.getHours();
    var NewMinute = NewDate.getMinutes();
    var Minutessss = NewMinute;
    var Hourssssss = NewHour;
    if (NewHour < 10) {
        Hourssssss = "0" + Hourssssss;
    }
    if (NewMinute < 10) {
        Minutessss = "0" + NewMinute;
    }
    var MessageTime = Hourssssss + ":" + Minutessss

    //$("#phone-time").html(MessageTime + " <span style='font-size: 1.1vh;'>" + data.InGameTime.hour + ":" + data.InGameTime.minute + "</span>");
}

var NotificationTimeout = null;

KR.Screen.Notification = function(title, content, icon, timeout, color) {
    $.post('http://phone/HasPhone', JSON.stringify({}), function(HasPhone){
        if (HasPhone) {
            if (color != null && color != undefined) {
                $(".screen-notifications-container").css({"background-color":color});
            }
            $(".screen-notification-icon").html('<i class="'+icon+'"></i>');
            $(".screen-notification-title").text(title);
            $(".screen-notification-content").text(content);
            $(".screen-notifications-container").css({'display':'block'}).animate({
                right: 5+"vh",
            }, 200);
        
            if (NotificationTimeout != null) {
                clearTimeout(NotificationTimeout);
            }
        
            NotificationTimeout = setTimeout(function(){
                $(".screen-notifications-container").animate({
                    right: -35+"vh",
                }, 200, function(){
                    $(".screen-notifications-container").css({'display':'none'});
                });
                NotificationTimeout = null;
            }, timeout);
        }
    });
}

// KR.Screen.Notification("Nieuwe Tweet", "Dit is een test tweet like #YOLO", "fab fa-twitter", 4000);

$(document).ready(function(){
    window.addEventListener('message', function(event) {
        switch(event.data.action) {
            case "open":
                KR.Phone.Functions.Open(event.data);
                KR.Phone.Functions.SetupAppWarnings(event.data.AppData);
                KR.Phone.Functions.SetupCurrentCall(event.data.CallData);
                KR.Phone.Data.IsOpen = true;
                KR.Phone.Data.PlayerData = event.data.PlayerData;
                break;
            // case "LoadPhoneApplications":
            //     KR.Phone.Functions.SetupApplications(event.data);
            //     break;
            case "LoadPhoneData":
                KR.Phone.Functions.LoadPhoneData(event.data);
                break;
            case "UpdateTime":
                KR.Phone.Functions.UpdateTime(event.data);
                break;
            case "Notification":
                KR.Screen.Notification(event.data.NotifyData.title, event.data.NotifyData.content, event.data.NotifyData.icon, event.data.NotifyData.timeout, event.data.NotifyData.color);
                break;
            case "PhoneNotification":
                KR.Phone.Notifications.Add(event.data.PhoneNotify.icon, event.data.PhoneNotify.title, event.data.PhoneNotify.text, event.data.PhoneNotify.color, event.data.PhoneNotify.timeout);
                break;
            case "RefreshAppAlerts":
                KR.Phone.Functions.SetupAppWarnings(event.data.AppData);                
                break;
                case "RefreshDarkwebs":
                    if (KR.Phone.Data.currentApplication == "darkweb") {
                        KR.Phone.Functions.RefreshDarkwebs(event.data.Darkwebs);
                     }
                  break;
            case "UpdateMentionedTweets":
                KR.Phone.Notifications.LoadMentionedTweets(event.data.Tweets);                
                break;
            case "UpdateBank":
                $(".bank-app-account-balance").html("&#36; "+event.data.NewBalance);
                $(".bank-app-account-balance").data('balance', event.data.NewBalance);
                break;
            case "UpdateChat":
                if (KR.Phone.Data.currentApplication == "whatsapp") {
                    if (OpenedChatData.number !== null && OpenedChatData.number == event.data.chatNumber) {
                        //console.log('Chat reloaded')
                        KR.Phone.Functions.SetupChatMessages(event.data.chatData);
                    } else {
                        //console.log('Chats reloaded')
                        KR.Phone.Functions.LoadWhatsappChats(event.data.Chats);
                    }
                }
                break;
            case "UpdateHashtags":
                KR.Phone.Notifications.LoadHashtags(event.data.Hashtags);
                break;
            case "RefreshWhatsappAlerts":
                KR.Phone.Functions.ReloadWhatsappAlerts(event.data.Chats);
                break;
            case "CancelOutgoingCall":
                $.post('http://phone/HasPhone', JSON.stringify({}), function(HasPhone){
                    if (HasPhone) {
                        CancelOutgoingCall();
                    }
                });
                break;
            case "IncomingCallAlert":
                $.post('http://phone/HasPhone', JSON.stringify({}), function(HasPhone){
                    if (HasPhone) {
                        IncomingCallAlert(event.data.CallData, event.data.Canceled, event.data.AnonymousCall);
                    }
                });
                break;
            case "SetupHomeCall":
                KR.Phone.Functions.SetupCurrentCall(event.data.CallData);
                break;
            case "AnswerCall":
                KR.Phone.Functions.AnswerCall(event.data.CallData);
                break;
            case "UpdateCallTime":
                var CallTime = event.data.Time;
                var date = new Date(null);
                date.setSeconds(CallTime);
                var timeString = date.toISOString().substr(11, 8);

                if (!KR.Phone.Data.IsOpen) {
                    if ($(".call-notifications").css("right") !== "52.1px") {
                        $(".call-notifications").css({"display":"block"});
                        $(".call-notifications").animate({right: 5+"vh"});
                    }
                    $(".call-notifications-title").html("Conversatie ("+timeString+")");
                    $(".call-notifications-content").html("Apel "+event.data.Name);
                    $(".call-notifications").removeClass('call-notifications-shake');
                } else {
                    $(".call-notifications").animate({
                        right: -35+"vh"
                    }, 400, function(){
                        $(".call-notifications").css({"display":"none"});
                    });
                }

                $(".phone-call-ongoing-time").html(timeString);
                $(".phone-currentcall-title").html("In conversatie ("+timeString+")");
                break;
            case "CancelOngoingCall":
                $(".call-notifications").animate({right: -35+"vh"}, function(){
                    $(".call-notifications").css({"display":"none"});
                });
                KR.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
                setTimeout(function(){
                    KR.Phone.Functions.ToggleApp("phone-call", "none");
                    $(".phone-application-container").css({"display":"none"});
                }, 400)
                KR.Phone.Functions.HeaderTextColor("white", 300);
    
                KR.Phone.Data.CallActive = false;
                KR.Phone.Data.currentApplication = null;
                break;
            case "RefreshContacts":
                KR.Phone.Functions.LoadContacts(event.data.Contacts);
                break;
            case "UpdateMails":
                KR.Phone.Functions.SetupMails(event.data.Mails);
                break;
            case "RefreshAdverts":
                if (KR.Phone.Data.currentApplication == "advert") {
                    KR.Phone.Functions.RefreshAdverts(event.data.Adverts);
                }
                break;
            case "AddPoliceAlert":
                AddPoliceAlert(event.data)
                break;
            case "AddHitmanAlert":
                AddHitmanAlert(event.data)
                break;
            case "UpdateApplications":
                KR.Phone.Data.PlayerJob = event.data.JobData;
                KR.Phone.Functions.SetupApplications(event.data);
                break;
            case "UpdateTransactions":
                RefreshCryptoTransactions(event.data);
                break;
            case "UpdateRacingApp":
                $.post('http://phone/GetAvailableRaces', JSON.stringify({}), function(Races){
                    SetupRaces(Races);
                });
                break;
        }
    })
});

//KR.Phone.Functions.Open();