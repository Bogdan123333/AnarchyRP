var CurrentdeepwebTab = "deepweb-home"
var HashtagOpen = false;
var MinimumTrending = 100;

$(document).on('click', '.deepweb-header-tab', function(e){
    e.preventDefault();

    var PresseddeepwebTab = $(this).data('deepwebtab');
    var PreviousdeepwebTabObject = $('.deepweb-header').find('[data-deepwebtab="'+CurrentdeepwebTab+'"]');

    if (PresseddeepwebTab !== CurrentdeepwebTab) {
        $(this).addClass('selected-deepweb-header-tab');
        $(PreviousdeepwebTabObject).removeClass('selected-deepweb-header-tab');

        $("."+CurrentdeepwebTab+"-tab").css({"display":"none"});
        $("."+PresseddeepwebTab+"-tab").css({"display":"block"});



        if (PresseddeepwebTab == "deepweb-home") {
            $.post('https://phone/GetDeep', JSON.stringify({}), function(Deep){
                KR.Phone.Notifications.LoadDeep(Deep);
            });
        }

        CurrentdeepwebTab = PresseddeepwebTab;

        if (HashtagOpen) {
            event.preventDefault();

            $(".deepweb-hashtag-tweets").css({"left": "30vh"});
            $(".deepweb-hashtags").css({"left": "0vh"});
            $(".deepweb-new-tweet").css({"display":"block"});
            $(".deepweb-hashtags").css({"display":"block"});
            HashtagOpen = false;
        }
    } else if (CurrentdeepwebTab == "deepweb-hashtags" && PresseddeepwebTab == "deepweb-hashtags") {
        if (HashtagOpen) {
            event.preventDefault();

            $(".deepweb-hashtags").css({"display":"block"});
            $(".deepweb-hashtag-tweets").animate({
                left: 30+"vh"
            }, 150);
            $(".deepweb-hashtags").animate({
                left: 0+"vh"
            }, 150);
            HashtagOpen = false;
        }
    } else if (CurrentdeepwebTab == "deepweb-home" && PresseddeepwebTab == "deepweb-home") {
        event.preventDefault();

        $.post('https://phone/GetTweets', JSON.stringify({}), function(Tweets){
            KR.Phone.Notifications.LoadTweets(Tweets);
        });
    } else if (CurrentdeepwebTab == "deepweb-mentions" && PresseddeepwebTab == "deepweb-mentions") {
        event.preventDefault();

        $.post('https://phone/GetMentionedTweets', JSON.stringify({}), function(MentionedTweets){
            KR.Phone.Notifications.LoadMentionedTweets(MentionedTweets)
        })
    }
});

$(document).on('click', '.deepweb-new-tweet', function(e){
    e.preventDefault();

    KR.Phone.Animations.TopSlideDown(".deepweb-new-tweet-tab", 450, 0);
});

$(document).on('click', '#send-photo', function (e) {
    e.preventDefault();
    $.post('http://phone/PostNewImage', JSON.stringify({}),
        function (url) {
            $('#tweet-new-url').val(url)
        },
    );
    KR.Phone.Functions.Close();

});

KR.Phone.Notifications.LoadDeep = function(Deep) {
    Deep = Deep.reverse();
    if (Deep !== null && Deep !== undefined && Deep !== "" && Deep.length > 0) {
        $(".deepweb-home-tab").html("");
        $.each(Deep, function(i, Tweet){
            var clean = DOMPurify.sanitize(Tweet.message , {
                ALLOWED_TAGS: [],
                ALLOWED_ATTR: []
            });
            if (clean == '') clean = 'Hmm, I shouldn\'t be able to do this...'
            var TwtMessage = KR.Phone.Functions.FormatdeepwebMessage(clean);
            var TimeAgo = moment(Tweet.date).format('MM/DD/YYYY hh:mm');

            var deepwebHandle = Tweet.firstName + ' ' + Tweet.lastName
            var PictureUrl = "./img/default.png"
            if (Tweet.picture !== "default") {
                PictureUrl = Tweet.picture
            }

            if (Tweet.url == "") {
                let TweetElement = '<div class="deepweb-tweet" data-twtcid="'+Tweet.citizenid+'" data-twtid ="'+Tweet.tweetId+'" data-twthandler="@' + deepwebHandle.replace(" ", "_") + '"><div class="tweet-reply"><i class="fas fa-reply"></i></div>' +
                    '<div class="tweet-tweeter">' + Tweet.firstName + ' ' + Tweet.lastName + ' &nbsp;<span>@' + deepwebHandle.replace(" ", "_") + ' &middot; ' + TimeAgo + '</span></div>' +
                    '<div class="tweet-message">' + TwtMessage + '</div>' +
                    '<div class="twt-img" style="top: 1vh;"><img src="' + PictureUrl + '" class="tweeter-image"></div>' +
                    '</div>';
                    $(".deepweb-home-tab").append(TweetElement);
            } else {
                let TweetElement = '<div class="deepweb-tweet" data-twthandler="@'+deepwebHandle.replace(" ", "_")+'"><div class="tweet-reply"><i class="fas fa-reply"></i></div>'+
                    '<div class="tweet-tweeter">'+Tweet.firstName+' '+Tweet.lastName+' &nbsp;<span>@'+deepwebHandle.replace(" ", "_")+' &middot; '+TimeAgo+'</span></div>'+
                    '<div class="tweet-message">'+TwtMessage+'</div>'+
                    '<img class="image" src= ' + Tweet.url + ' style = " border-radius:4px; width: 70%; position:relative; z-index: 1; left:52px; margin:.6rem .5rem .6rem 1rem;height: auto; padding-bottom: 15px;">' +
                    '<div class="twt-img" style="top: 1vh;"><img src="'+PictureUrl+'" class="tweeter-image"></div>' +
                    '</div>';
                $(".deepweb-home-tab").append(TweetElement);
            }
            // if (Tweet.citizenid === KR.Phone.Data.PlayerData.citizenid){
            //     $(".tweet-message").append('<span><div class="twt-icon"><i class="fas fa-trash"style="position:absolute; right:2%; font-size: 1.5rem; z-index:4;" id ="twt-delete-click"></i></div>')
            // }
        });
    }
}

$(document).on('click','#twt-delete-click',function(e){
    e.preventDefault();
    let source = $('.deepweb-tweet').data('twtid')
    $(this).parent().parent().parent().parent().remove()
    $.post('https://phone/DeleteTweet', JSON.stringify({id: source}))
})

$(document).on('click', '.tweet-reply', function(e){
    e.preventDefault();
    var TwtName = $(this).parent().data('twthandler');
    $('#tweet-new-url').val("");
    $("#tweet-new-message").val(TwtName + " ");
    KR.Phone.Animations.TopSlideDown(".deepweb-new-tweet-tab", 450, 0);
});

KR.Phone.Notifications.LoadMentionedDeep = function(Deep) {
    Deep = Tweets.reverse();
    $('#tweet-new-url').val("");
    if (Tweets.length > 0) {
        $(".deepweb-mentions-tab").html("");
        $.each(Tweets, function(i, Tweet){
            var clean = DOMPurify.sanitize(Tweet.message , {
                ALLOWED_TAGS: [],
                ALLOWED_ATTR: []
            });
            if (clean == '') clean = 'Hmm, I shouldn\'t be able to do this...'
            var TwtMessage = KR.Phone.Functions.FormatdeepwebMessage(clean);
            var TimeAgo = moment(Tweet.date).format('MM/DD/YYYY hh:mm');

            var deepwebHandle = Tweet.firstName + ' ' + Tweet.lastName
            var PictureUrl = "./img/default.png";
            if (Tweet.picture !== "default") {
                PictureUrl = Tweet.picture
            }

            var TweetElement =
            '<div class="deepweb-tweet">'+
                '<div class="tweet-tweeter">'+Tweet.firstName+' '+Tweet.lastName+' &nbsp;<span>@'+deepwebHandle.replace(" ", "_")+' &middot; '+TimeAgo+'</span></div>'+
                '<div class="tweet-message">'+TwtMessage+'</div>'+
            '<div class="twt-img" style="top: 1vh;"><img src="'+PictureUrl+'" class="tweeter-image"></div></div>';

            $(".deepweb-mentioned-tweet").css({"background-color":"#F5F8FA"});
            $(".deepweb-mentions-tab").append(TweetElement);
        });
    }
}

KR.Phone.Functions.FormatdeepwebMessage = function(deepwebMessage) {
    var TwtMessage = deepwebMessage;
    var res = TwtMessage.split("@");
    var tags = TwtMessage.split("#");
    var InvalidSymbols = [
        "[",
        "?",
        "!",
        "@",
        "#",
        "]",
    ]

    for(i = 1; i < res.length; i++) {
        var MentionTag = res[i].split(" ")[0];
        if (MentionTag !== null && MentionTag !== undefined && MentionTag !== "") {
            TwtMessage = TwtMessage.replace("@"+MentionTag, "<span class='mentioned-tag' data-mentiontag='@"+MentionTag+"''>@"+MentionTag+"</span>");
        }
    }

    for(i = 1; i < tags.length; i++) {
        var Hashtag = tags[i].split(" ")[0];

        for(i = 1; i < InvalidSymbols.length; i++){
            var symbol = InvalidSymbols[i];
            var res = Hashtag.indexOf(symbol);

            if (res > -1) {
                Hashtag = Hashtag.replace(symbol, "");
            }
        }

        if (Hashtag !== null && Hashtag !== undefined && Hashtag !== "") {
            TwtMessage = TwtMessage.replace("#"+Hashtag, "<span class='hashtag-tag-text' data-hashtag='"+Hashtag+"''>#"+Hashtag+"</span>");
        }
    }

    return TwtMessage
}

$(document).on('click', '#send-tweet', function(e){
    e.preventDefault();
    var TweetMessage = $("#tweet-new-message").val();
    var imageURL = $('#tweet-new-url').val()
    if (TweetMessage != "") {
        var CurrentDate = new Date();
        $.post('https://phone/PostNewTweet', JSON.stringify({
            Message: TweetMessage,
            Date: CurrentDate,
            Picture: KR.Phone.Data.MetaData.profilepicture,
            url: imageURL
        }), function(Tweets){
            KR.Phone.Notifications.LoadTweets(Tweets);
        });
        $.post('https://phone/GetHashtags', JSON.stringify({}), function(Hashtags){
            KR.Phone.Notifications.LoadHashtags(Hashtags)
        })
        KR.Phone.Animations.TopSlideUp(".deepweb-new-tweet-tab", 450, -120);
    } else {
        KR.Phone.Notifications.Add("fab fa-deepweb", "deepweb", "Trebuie sa pui un mesaj", "#1DA1F2");
    };
    $('#tweet-new-url').val("");
    $("#tweet-new-message").val("");
});

$(document).on('click', '#cancel-tweet', function(e){
    e.preventDefault();
    $('#tweet-new-url').html("");
    KR.Phone.Animations.TopSlideUp(".deepweb-new-tweet-tab", 450, -120);
});

$(document).on('click', '.image', function(e){
    e.preventDefault();
    let source = $(this).attr('src')
    KR.Screen.popUp(source)
});

$(document).on('click', '.mentioned-tag', function(e){
    e.preventDefault();
    CopyMentionTag(this);
});

$(document).on('click', '.hashtag-tag-text', function(e){
    e.preventDefault();
    if (!HashtagOpen) {
        var Hashtag = $(this).data('hashtag');
        var PreviousdeepwebTabObject = $('.deepweb-header').find('[data-deepwebtab="'+CurrentdeepwebTab+'"]');

        $("#deepweb-hashtags").addClass('selected-deepweb-header-tab');
        $(PreviousdeepwebTabObject).removeClass('selected-deepweb-header-tab');

        $("."+CurrentdeepwebTab+"-tab").css({"display":"none"});
        $(".deepweb-hashtags-tab").css({"display":"block"});

        $.post('https://phone/GetHashtagMessages', JSON.stringify({hashtag: Hashtag}), function(HashtagData){
            KR.Phone.Notifications.LoadHashtagMessages(HashtagData.messages);
        });

        $(".deepweb-hashtag-tweets").css({"display":"block", "left":"30vh"});
        $(".deepweb-hashtag-tweets").css({"left": "0vh"});
        $(".deepweb-hashtags").css({"left": "-30vh"});
        $(".deepweb-hashtags").css({"display":"none"});
        HashtagOpen = true;

        CurrentdeepwebTab = "deepweb-hashtags";
    }
});

function CopyMentionTag(elem) {
    var $temp = $("<input>");
    $("body").append($temp);
    $temp.val($(elem).data('mentiontag')).select();
    KR.Phone.Notifications.Add("fab fa-deepweb", "deepweb", $(elem).data('mentiontag')+ " copiat!", "rgb(27, 149, 224)", 1250);
    document.execCommand("copy");
    $temp.remove();
}

KR.Phone.Notifications.LoadHashtags = function(hashtags) {
    if (hashtags !== null) {
        $(".deepweb-hashtags").html("");

        $.each(hashtags, function(i, hashtag){
            var Elem = '';
            var TweetHandle = "Tweet";
            if (hashtag.messages.length > 1 ) {
               TweetHandle = "Tweets";
            }
            if (hashtag.messages.length >= MinimumTrending) {
                Elem = '<div class="deepweb-hashtag" id="tag-'+hashtag.hashtag+'"><div class="deepweb-hashtag-status">Trending in City</div> <div class="deepweb-hashtag-tag">#'+hashtag.hashtag+'</div> <div class="deepweb-hashtag-messages">'+hashtag.messages.length+' '+TweetHandle+'</div> </div>';
            } else {
                Elem = '<div class="deepweb-hashtag" id="tag-'+hashtag.hashtag+'"><div class="deepweb-hashtag-status">Not trending in City</div> <div class="deepweb-hashtag-tag">#'+hashtag.hashtag+'</div> <div class="deepweb-hashtag-messages">'+hashtag.messages.length+' '+TweetHandle+'</div> </div>';
            }

            $(".deepweb-hashtags").append(Elem);
            $("#tag-"+hashtag.hashtag).data('tagData', hashtag);
        });
    }
}

KR.Phone.Notifications.LoadHashtagMessages = function(Tweets) {
    Deep = Tweets.reverse();
    if (Deep !== null && Deep !== undefined && Deep !== "" && Tweets.length > 0) {
        $(".deepweb-hashtag-tweets").html("");
        $.each(Tweets, function(i, Tweet){
            var clean = DOMPurify.sanitize(Tweet.message , {
                ALLOWED_TAGS: [],
                ALLOWED_ATTR: []
            });
            if (clean == '') clean = 'Hmm, I shouldn\'t be able to do this...'
            var TwtMessage = KR.Phone.Functions.FormatdeepwebMessage(clean);
            var TimeAgo = moment(Tweet.date).format('MM/DD/YYYY hh:mm');

            var deepwebHandle = Tweet.firstName + ' ' + Tweet.lastName
            var PictureUrl = "./img/default.png"
            if (Tweet.picture !== "default") {
                PictureUrl = Tweet.picture
            }

            var TweetElement =
            '<div class="deepweb-tweet">'+
                '<div class="tweet-tweeter">'+Tweet.firstName+' '+Tweet.lastName+' &nbsp;<span>@'+deepwebHandle.replace(" ", "_")+' &middot; '+TimeAgo+'</span></div>'+
                '<div class="tweet-message">'+TwtMessage+'</div>'+
            '<div class="twt-img" style="top: 1vh;"><img src="'+PictureUrl+'" class="tweeter-image"></div></div>';

            $(".deepweb-hashtag-tweets").append(TweetElement);
        });
    }
}


$(document).on('click', '.deepweb-hashtag', function(event){
    event.preventDefault();

    var TweetId = $(this).attr('id');
    var TweetData = $("#"+TweetId).data('tagData');

    KR.Phone.Notifications.LoadHashtagMessages(TweetData.messages);

    $(".deepweb-hashtag-tweets").css({"display":"block", "left":"30vh"});
    $(".deepweb-hashtag-tweets").animate({
        left: 0+"vh"
    }, 150);
    $(".deepweb-hashtags").animate({
        left: -30+"vh"
    }, 150, function(){
        $(".deepweb-hashtags").css({"display":"none"});
    });
    HashtagOpen = true;
});