const tableColors = [
    ["140,140,140"],
    ["223,110,87"],
    ["238,214,50"],
    ["30,240,70"],
    ["202,25,240"],
    ["25,167,240"],
    ["25,240,227"],
    ["177,231,73"],
    ["255,7,13"],
    ["182,48,215"],
    ["37,28,206"],
    ["82,58,10"],
    ["78,235,229"],
    ["255,255,255"],
    ["0,0,0"],
    ["45,108,45"],
];

let vehicles = [];
let vehicleStocks = [];
let selectedVehicle = 0;
let selectedCat = 0;
let selectedColor = 0;

$(document).ready(() => {
    $("body").append("<div id = 'showroom'> </div>");
    $("body").append("<div id = 'timeRemaining'></div>");
    $("#showroom").css("display", "none");
    $("#timeRemaining").css("display", "none");
    document.onkeyup = (data) => {
        switch (data.whicha) {
            case 27:
                $( "#showroom" ).fadeOut(500);
                $("#showroom").empty();
                $.post('http://esk_dealership/closeShowroom', JSON.stringify({}));
                vehicles = [];
                vehicleStocks = [];
                selectedVehicle = 0;
                selectedCat = 0;
                selectedColor = 0;
                break;
            default:
                break;
        };
    };
});

function sortAlphabetic(obj) {
    return Object.keys(obj).sort().reduce((result, key) => {
      result[key] = obj[key];
      return result;
    }, {});
};

function sortByPrice(obj) {
    return Object.keys(obj).sort((a, b) => {
        if (obj[a]["price"] < obj[b]["price"]) return -1;
        if (obj[a]["price"] > obj[b]["price"]) return 1;
        return 0;
    });
};

window.addEventListener("message", (event) => {
    const data = event.data;
    switch (data.action) {
        case "openShowroonJS":
            vehicles = sortAlphabetic(data.veh_table);
            vehicleStocks = data.veh_stocks;

            switch (data.sh_type) {
                case "car":
                    $("#showroom").css("background-image", "url('https://cdn.discordapp.com/attachments/789540841106178118/897604183656661062/background.png')");
                    break;
                case "boat":
                    $("#showroom").css("background-image", "url('https://cdn.discordapp.com/attachments/789540841106178118/897606243353514004/barca.png')");
                    break;
                case "air":
                    $("#showroom").css("background-image", "url('https://cdn.discordapp.com/attachments/789540841106178118/897606244293046352/avion.png')");
                    break;
                default:
                    break;
            };

            $("#timeRemaining").css("display", "none");
            $("#showroom").fadeIn(500);
            $("#showroom").append(
                '<div id = "main_menu">'+
                    '<div class = "centered_box_inMenu">'+
                        '<div class = sh_header>'+
                            '<h2>Dealership</h2> <h1 id = "sh_name">'+data.sh_name+'</h1><a>Bine ați venit pe SERVER, aici puteți vedea toate vehiculele uimitoare din Orasul Nostru</a>'+
                        '</div>'+
                        '<div class = "sh_vehicles">'+
                            '<p class = "drawline"><strong><i class="fad fa-car-side"></i> Lista cu Categorii</strong></p>'+
                        '</div>'+
                        '<div class = "sh_vehcolors">'+
                            '<p class = "drawline"><strong><i class="fad fa-spray-can"></i> List cu culori</strong></p>'+
                            '<div class = "colors"> </div>'+
                        '</div>'+
                        '<div class = "sh_vehpurchase">'+
                            '<p class = "drawline"><strong><i class="fad fa-dollar-sign"></i> SERVER</strong></p>'+
                            '<button onclick="buyVehicle()" id = "buy"> <h2><strong><i class="fad fa-dollar-sign"></i> Cumpara Masina</strong></h2></button>'+
                        '</div>'+
                        '<div class = "sh_vehpurchase" style="margin-top:-12%">'+
                            '<p class = "drawline"><strong><i class="fa-solid fa-check"></i> SERVER</strong></p>'+
                            '<button onclick="spawnVehicleForTest()"> <h2><strong><i class="fa-solid fa-check"></i> Testeaza Masina</strong></h2></button>'+
                        '</div>'+
                        '<div class = "sh_vehpurchase" id="back">'+
                            '<p class = "drawline"><strong><i class="fa-solid fa-rotate-left"></i> SERVER</strong></p>'+
                            '<button onclick="back()"> <h2><strong><i class="fa-solid fa-rotate-left"></i> Inapoi</strong></h2></button>'+
                        '</div>'+
                        '<div class = "sh_vehpurchase" id="exit">'+
                            '<p class = "drawline"><strong><i class="fa-solid fa-xmark"></i> SERVER</strong></p>'+
                            '<button onclick="exit()"> <h2><strong><i class="fa-solid fa-xmark"></i> Iesi din Showroom</strong></h2></button>'+
                        '</div>'+
                    '</div>'+
                '</div>'+
    
                '<div id = "stats_menu">'+
                    '<div class = "centered_box_inSpecification">'+
                        '<div class = "sh_specifications" style = "display:none">'+
    
                            '<p class = "drawline"><strong><i class="fad fa-cogs"></i> Specificatii:</strong></p>'+
    
                            '<div class="prog-bar">'+
                                '<div class="info"><span class = "left">Viteza</span> <span class = "right" id = "kmh">0km/h</span> </div>'+
                                '<div class="progress-bar"><div class = "progress-bar-size" id = "kmh_prog"><span></span></div></div>'+
                            '</div>'+
                            '<div class="prog-bar">'+
                                '<div class="info"><span class = "left">Acceleratie</span> <span class = "right" id = "acceleration">x/x</span> </div>'+
                                '<div class="progress-bar"><div class = "progress-bar-size"  id = "acceleration_prog"><span></span></div></div>'+
                            '</div>'+
                            '<div class="prog-bar">'+
                                '<div class="info"><span class = "left">Frane</span> <span class = "right" id = "brakes">x/x</span> </div>'+
                                '<div class="progress-bar"><div class = "progress-bar-size" id = "brakes_prog"><span></span></div></div>'+
                            '</div>'+
                            '<div class="prog-bar">'+
                                '<div class="info"><span class = "left">Locuri</span> <span class = "right" id = "seats">x/x</span> </div>'+
                                '<div class="progress-bar"><div class = "progress-bar-size" id = "seats_prog"><span></span></div></div>'+
                            '</div>'+
    
                            '<p class = "drawline"><strong><i class="fas fa-exclamation-triangle"></i>Informatie:</strong></p>'+
                            '<a>Daca testezi o masina, te afli în Virtual World. Asta înseamnă că nimeni nu poate face zgomot și nimeni nu te poate ucide. Dacă trebuie să opriti din a vă testa mașina, Iesiti din Vehicul.</a>'+
                        '</div>'+
                    '</div>'+
                '</div>'
            );

            $(".sh_vehcolors").hide();
            $(".sh_vehpurchase").hide();
            $("#exit").show();
            $.each(vehicles, function (index) {
                $(".sh_vehicles").append(`<button onclick="selectCat('${index}')"><h2>${index}</h2></button>`);
            });
            for (let i = 0; i < 16; i++) {
                $(".colors").append('<button style = background-color:rgba('+tableColors[i]+'); onclick="changeColor('+i+')""></button>');
            };
            break;
        case "updateVehicleSpecifications":
            if($('.sh_specifications').css('display') == 'none'){ 
                $( ".sh_specifications").fadeIn(500);
            }
            $("#testprice").text("$"+numberWithCommas(data.testPrice));
            $("#kmh").text(data.speed.text);
            $("#acceleration").text(data.acceleration.text);
            $("#brakes").text(data.brakes.text);
            $("#seats").text(data.seats.text);
            $("#kmh_prog").css("width",data.speed.barsize+"%");
            $("#acceleration_prog").css("width",data.acceleration.barsize+"%");
            $("#brakes_prog").css("width",data.brakes.barsize+"%");
            $("#seats_prog").css("width",data.seats.barsize+"%");
            $("#kmh_prog span").css("left",data.speed.barsize+"%");
            $("#acceleration_prog span").css("left",data.acceleration.barsize+"%");
            $("#brakes_prog span").css("left",data.brakes.barsize+"%");
            $("#seats_prog span").css("left",data.seats.barsize+"%");
            break;
        case "timeRemaining":
            $("#timeRemaining").css("display", "block");
            $("#timeRemaining").html(data.timeRemaining);
            break;
        case "startTestingTheVehicle":
            $("#showroom" ).fadeOut(500);
            $("#showroom").empty();
            $( "#timeRemaining" ).fadeIn(500);
            break;
        case "closeShowroom":
            exit();
            break;
        default:
            break;
    };
});

function spawnTheVehicle(id, index) {
    selectedVehicle = id;
    selectedCat = index;
    $(".sh_vehcolors").show();
    $(".sh_vehpurchase").show();
    $("#back").css("margin-top", "-12%");
    $("#exit").hide();
    $.post('http://esk_dealership/spawnTheVehicle', JSON.stringify({id, selectedCat}));
}

function selectCat(cat) {
    if (!cat || !vehicles[cat]) return;
    $('.sh_vehicles').html('<p class = "drawline"><strong><i class="fad fa-car-side"></i> List of vehicles</strong></p>');
    $("#back").show();
    $("#exit").hide();
    $.each(sortByPrice(vehicles[cat]), function(_,idx) {
        const value = vehicles[cat][idx];
        $(".sh_vehicles").append(`<button onclick="spawnTheVehicle(${value.vehID},'${cat}')"><h2>${idx} <a class = "stocks">(${(vehicleStocks[idx] == undefined || vehicleStocks[idx].stock == undefined) ? 0 : vehicleStocks[idx].stock} STOCK)</a><h3> $${numberWithCommas(value.price)}</h3></h2> </button>`);
    });
};

function back() {
    selectedVehicle = 0;
    selectedCat = 0;
    $(".sh_vehcolors").hide();
    $(".sh_vehpurchase").hide();
    $(".sh_specifications").hide();
    $("#back").css("margin-top", "10px");
    $("#exit").show();
    $('.sh_vehicles').html('<p class = "drawline"><strong><i class="fad fa-car-side"></i> List of categories</strong></p>');
    $.each(vehicles, (index) => {
        $(".sh_vehicles").append(`<button onclick="selectCat('${index}')"><h2>${index}</h2></button>`);
    });
};

function exit() {
    $("#showroom").fadeOut(500);
    $("#showroom").empty();
    $.post('http://esk_dealership/closeShowroom', "[]");
    vehicles = [];
    vehicleStocks = [];
    selectedVehicle = 0;
    selectedCat = 0;
    selectedColor = 0;
};

function changeColor(id) {
    colours = tableColors[id];
    $.post('http://esk_dealership/changeVehicleColors', JSON.stringify({colours}));
    selectedColor = colours;
};

function spawnVehicleForTest() {
    if (selectedVehicle && selectedCat) {
        $.post('http://esk_dealership/spawnTheVehicleForTesting', JSON.stringify({selectedColor, selectedVehicle, selectedCat}));
    };
};

function buyVehicle() {
    if (selectedVehicle) {
        $.post('http://esk_dealership/buyVehicle', JSON.stringify({selectedColor, selectedVehicle}));
    };
};

function numberWithCommas(x) {
    const parts = x.toString().split(".");
    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return parts.join(".");
};