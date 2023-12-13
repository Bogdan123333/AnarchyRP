KR.Phone.Settings = {};
KR.Phone.Settings.Background = "default-fplayt";
KR.Phone.Settings.OpenedTab = null;
KR.Phone.Settings.Backgrounds = {
    'default-fplayt': {
        label: "Fundal Standard"
    }
};

var PressedBackground = null;
var PressedBackgroundObject = null;
var OldBackground = null;
var IsChecked = null;

$(document).on('click', '.settings-app-tab', function(e){
    e.preventDefault();
    var PressedTab = $(this).data("settingstab");

    if (PressedTab == "background") {
        KR.Phone.Animations.TopSlideDown(".settings-"+PressedTab+"-tab", 200, 0);
        KR.Phone.Settings.OpenedTab = PressedTab;
    } else if (PressedTab == "profilepicture") {
        KR.Phone.Animations.TopSlideDown(".settings-"+PressedTab+"-tab", 200, 0);
        KR.Phone.Settings.OpenedTab = PressedTab;
    } else if (PressedTab == "numberrecognition") {
        var checkBoxes = $(".numberrec-box");
        KR.Phone.Data.AnonymousCall = !checkBoxes.prop("checked");
        checkBoxes.prop("checked", KR.Phone.Data.AnonymousCall);
        if (!KR.Phone.Data.AnonymousCall) {
            $("#numberrecognition > p").html('Oprit');
        } else {
            $("#numberrecognition > p").html('Pornit');
        }
    } else if (PressedTab == "sizerecognition") {
        var MareMic = $(".sizerec-box");
        KR.Phone.Data.MareMic = !MareMic.prop("checked");
        MareMic.prop("checked", KR.Phone.Data.MareMic);
        console.log(KR.Phone.Data.MareMic);
        if (KR.Phone.Data.MareMic) {
            $("#sizerecognition > p").html('Mic');
            $(".phone-frame").css("width", '27vh');
            $(".phone-frame").css("height", '50.3vh');
            $(".phone-background").css("background-position-x", "-1.50vh");
            $(".phone-container").css("width", "24vh");
            $(".phone-container").css("height", "48.90vh");
            $(".phone-header").css("top", "-0.5vh");
            $(".phone-application").css("top", "-100px");
            $(".phone-application").css("height", "3.8vh");
            $(".phone-application").css("width", "3.8vh");
            $(".phone-application").css("left", "0vh");
            $(".phone-application > i").css("line-height", "3.8vh");
            $(".phone-application > i").css("font-size", "1.7vh");
            $(".phone-footer-applications").css("bottom", "10%");
            $(".phone-keypad-keys").css("width", "15vh");
            $(".phone-keypad-keys").css("height", "20vh");
            $(".phone-keypad-keys").css("left", "4.2vh");
            $(".phone-keypad-keys").css("top", "14vh");
            $(".phone-keypad-key-call").css("bottom", "6vh")
            $(".phone-keypad-key-call").css("left", "9.2vh")
            $(".phone-contact-action-buttons > i").css("left", "-2.3vh");
            $(".advert-list-imobiliare").css("height", "26.5vh");
            $(".advert-list-vehicule").css("height", "26.5vh");
            $(".advert-list-comerciale").css("height", "26.5vh");
            $(".new-advert-footer-vehicule").css("top", "39vh");
            $(".new-advert-footer-imobiliare").css("top", "39vh");
            $(".new-advert-footer").css("top", "39vh");
            $(".twitter-new-tweet-tab").css("top", "-120%")
            $(".whatsapp-openedchat-messages").css("height", "52%");
            $("#whatsapp-openedchat-send").css("z-index", "999");
        } else {
            $("#sizerecognition > p").html("Mare");
            $(".phone-container").css("width", '29vh');
            $(".phone-container").css("height", '61.7vh');
            $(".phone-frame").css("width", '32vh');
            $(".phone-frame").css("height", '63vh');
            $(".phone-background").css("background-position-x", "-2.65vh");
            $(".phone-header").css("top", "0.2vh");
            $(".phone-application").css("top", "-40px");
            $(".phone-application").css("height", "4.6vh");
            $(".phone-application").css("width", "4.6vh");
            $(".phone-application").css("left", "1vh");
            $(".phone-application > i").css("line-height", "4.6vh");
            $(".phone-application > i").css("font-size", "2vh");
            $(".phone-footer-applications").css("bottom", "5%");
            $(".phone-keypad-keys").css("width", "23vh");
            $(".phone-keypad-keys").css("height", "27vh");
            $(".phone-keypad-keys").css("left", "3vh");
            $(".phone-keypad-keys").css("top", "17vh");
            $(".phone-keypad-key-call").css("bottom", "8vh")
            $(".phone-keypad-key-call").css("left", "11.7vh")
            $(".phone-contact-action-buttons > i").css("left", "-.2vh");
            $(".advert-list-imobiliare").css("height", "39.5vh");
            $(".advert-list-vehicule").css("height", "39.5vh");
            $(".advert-list-comerciale").css("height", "39.5vh");
            $(".new-advert-footer-vehicule").css("top", "51vh");
            $(".new-advert-footer-imobiliare").css("top", "51vh");
            $(".twitter-new-tweet-tab").css("top", "-120%")
            $(".new-advert-footer").css("top", "51vh");
            $(".twitter-new-tweet-tab").css("top", "-100%");
            $(".whatsapp-openedchat-messages").css("height", "62%");
        }
    }
});

$(document).on('click', '#accept-background', function(e){
    e.preventDefault();
    var hasCustomBackground = KR.Phone.Functions.IsBackgroundCustom();

    if (hasCustomBackground === false) {
        KR.Phone.Notifications.Add("fas fa-paint-brush", "Setari", KR.Phone.Settings.Backgrounds[KR.Phone.Settings.Background].label+" setat!")
        KR.Phone.Animations.TopSlideUp(".settings-"+KR.Phone.Settings.OpenedTab+"-tab", 200, -100);
        $(".phone-background").css({"background-image":"url('https://i.imgur.com/oVA9LDA.png')"})
    } else {
        KR.Phone.Notifications.Add("fas fa-paint-brush", "Setari", "Fundal personalizat setat!")
        KR.Phone.Animations.TopSlideUp(".settings-"+KR.Phone.Settings.OpenedTab+"-tab", 200, -100);
        $(".phone-background").css({"background-image":"url('"+KR.Phone.Settings.Background+"')"});
    }

    $.post('http://phone/SetBackground', JSON.stringify({
        background: KR.Phone.Settings.Background,
    }))
});

KR.Phone.Functions.LoadMetaData = function(MetaData) {
    if (MetaData.background !== null && MetaData.background !== undefined) {
        KR.Phone.Settings.Background = MetaData.background;
    } else {
        KR.Phone.Settings.Background = "default-fplayt";
    }

    var hasCustomBackground = KR.Phone.Functions.IsBackgroundCustom();

    if (!hasCustomBackground) {
        $(".phone-background").css({"background-image":"url('https://media.discordapp.net/attachments/1056880321062260768/1068675247865344100/photo-1554844453-7ea2a562a6c8.jpg?width=355&height=473')"})
    } else {
        $(".phone-background").css({"background-image":"url('"+KR.Phone.Settings.Background+"')"});
    }

    if (MetaData.profilepicture == "default" || MetaData.profilepicture == undefined) {
        $("[data-settingstab='profilepicture']").find('.settings-tab-icon').html('<img src="./img/default.png">');
    } else {
        $("[data-settingstab='profilepicture']").find('.settings-tab-icon').html('<img src="'+MetaData.profilepicture+'">');
    }
}

$(document).on('click', '#cancel-background', function(e){
    e.preventDefault();
    KR.Phone.Animations.TopSlideUp(".settings-"+KR.Phone.Settings.OpenedTab+"-tab", 200, -100);
});

KR.Phone.Functions.IsBackgroundCustom = function() {
    var retval = true;
    $.each(KR.Phone.Settings.Backgrounds, function(i, background){
        if (KR.Phone.Settings.Background == i) {
            retval = false;
        }
    });
    return retval
}

$(document).on('click', '.background-option', function(e){
    e.preventDefault();
    PressedBackground = $(this).data('background');
    PressedBackgroundObject = this;
    OldBackground = $(this).parent().find('.background-option-current');
    IsChecked = $(this).find('.background-option-current');

    if (IsChecked.length === 0) {
        if (PressedBackground != "custom-background") {
            KR.Phone.Settings.Background = PressedBackground;
            $(OldBackground).fadeOut(50, function(){
                $(OldBackground).remove();
            });
            $(PressedBackgroundObject).append('<div class="background-option-current"><i class="fas fa-check-circle"></i></div>');
        } else {
            KR.Phone.Animations.TopSlideDown(".background-custom", 200, 13);
        }
    }
});

$(document).on('click', '#accept-custom-background', function(e){
    e.preventDefault();

    KR.Phone.Settings.Background = $(".custom-background-input").val();
    $(OldBackground).fadeOut(50, function(){
        $(OldBackground).remove();
    });
    $(PressedBackgroundObject).append('<div class="background-option-current"><i class="fas fa-check-circle"></i></div>');
    KR.Phone.Animations.TopSlideUp(".background-custom", 200, -23);
});

$(document).on('click', '#cancel-custom-background', function(e){
    e.preventDefault();

    KR.Phone.Animations.TopSlideUp(".background-custom", 200, -23);
});

// Profile Picture

var PressedProfilePicture = null;
var PressedProfilePictureObject = null;
var OldProfilePicture = null;
var ProfilePictureIsChecked = null;

$(document).on('click', '#accept-profilepicture', function(e){
    e.preventDefault();
    var ProfilePicture = KR.Phone.Data.PlayerData.profilepicture;
    if (ProfilePicture === "default" || ProfilePicture == undefined) {
        KR.Phone.Notifications.Add("fas fa-paint-brush", "Setari", "Poza de profil standard a fost setata!")
        KR.Phone.Animations.TopSlideUp(".settings-"+KR.Phone.Settings.OpenedTab+"-tab", 200, -100);
        $("[data-settingstab='profilepicture']").find('.settings-tab-icon').html('<img src="https://cdn.discordapp.com/attachments/966830209640857730/966854390524837938/default-qbus.png">');
    } else {
        KR.Phone.Notifications.Add("fas fa-paint-brush", "Setari", "Poza de profil personalizata a fost setata!")
        KR.Phone.Animations.TopSlideUp(".settings-"+KR.Phone.Settings.OpenedTab+"-tab", 200, -100);
        console.log(ProfilePicture)
        $("[data-settingstab='profilepicture']").find('.settings-tab-icon').html('<img src="'+ProfilePicture+'">');
    }
    $.post('http://phone/UpdateProfilePicture', JSON.stringify({
        profilepicture: ProfilePicture,
    }));
});

$(document).on('click', '#accept-custom-profilepicture', function(e){
    e.preventDefault();
    KR.Phone.Data.PlayerData.profilepicture = $(".custom-profilepicture-input").val();
    $(OldProfilePicture).fadeOut(50, function(){
        $(OldProfilePicture).remove();
    });
    $(PressedProfilePictureObject).append('<div class="profilepicture-option-current"><i class="fas fa-check-circle"></i></div>');
    KR.Phone.Animations.TopSlideUp(".profilepicture-custom", 200, -23);
});

$(document).on('click', '.profilepicture-option', function(e){
    e.preventDefault();
    PressedProfilePicture = $(this).data('profilepicture');
    PressedProfilePictureObject = this;
    OldProfilePicture = $(this).parent().find('.profilepicture-option-current');
    ProfilePictureIsChecked = $(this).find('.profilepicture-option-current');
    if (ProfilePictureIsChecked.length === 0) {
        if (PressedProfilePicture != "custom-profilepicture") {
            KR.Phone.Data.PlayerData.profilepicture = PressedProfilePicture
            $(OldProfilePicture).fadeOut(50, function(){
                $(OldProfilePicture).remove();
            });
            $(PressedProfilePictureObject).append('<div class="profilepicture-option-current"><i class="fas fa-check-circle"></i></div>');
        } else {
            KR.Phone.Animations.TopSlideDown(".profilepicture-custom", 200, 13);
        }
    }
});

$(document).on('click', '#cancel-profilepicture', function(e){
    e.preventDefault();
    KR.Phone.Animations.TopSlideUp(".settings-"+KR.Phone.Settings.OpenedTab+"-tab", 200, -100);
});


$(document).on('click', '#cancel-custom-profilepicture', function(e){
    e.preventDefault();
    KR.Phone.Animations.TopSlideUp(".profilepicture-custom", 200, -23);
});