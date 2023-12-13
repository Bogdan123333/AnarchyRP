// DarkWeb JS

$(document).on('click', '.test-slet', function(e){
    e.preventDefault();

    $(".darkweb-home").animate({
        left: 30+"vh"
    });
    $(".new-darkweb").animate({
        left: 0+"vh"
    });
});

$(document).on('click', '#new-darkweb-back', function(e){
    e.preventDefault();

    $(".darkweb-home").animate({
        left: 0+"vh"
    });
    $(".new-darkweb").animate({
        left: -30+"vh"
    });
});

$(document).on('click', '#new-darkweb-submit', function(e){
    e.preventDefault();

    var Darkweb = $(".new-darkweb-textarea").val();

    if (Darkweb !== "") {
        $(".darkweb-home").animate({
            left: 0+"vh"
        });
        $(".new-darkweb").animate({
            left: -30+"vh"
        });
        $.post('http://phone/PostDarkweb', JSON.stringify({
            message: Darkweb,
        }));
    } else {
        KR.Phone.Notifications.Add("fas fa-ad", "Deep Web", "Nu poti posta ceva gol!", "#ff8f1a", 2000);
    }
});

KR.Phone.Functions.RefreshDarkwebs = function(Darkwebs) {
    $("#darkweb-header-name").html("@Anonymous");
    if (Darkwebs.length > 0 || Darkwebs.length == undefined) {
        $(".darkweb-list").html("");
        $.each(Darkwebs, function(i, darkweb){
            if (i != Darkwebs.length) {
                if (darkweb.message !== null) {
                    var element = '<div class="darkweb"><span class="darkweb-sender"></span><p>'+darkweb.message+'</p></div>';
                    $(".darkweb-list").append(element);
                }
            }
            
        });
    } else {
        $(".darkweb-list").html("");
        var element = '<div class="darkweb"><span class="darkweb-sender">Deocamdata nu este niciun mesaj postat!</span></div>';
        $(".darkweb-list").append(element);
    }
}