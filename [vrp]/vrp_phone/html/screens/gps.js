
APPS.gps = {
    layout: $(".gps"),
    placesList: $(".gps > .list"),
    backBtn: $(".gps > header > .actions > .return"),

    menuItems: {
        "Important Locations": {category: "important_places", items: {
            "Life Invader": [-1082.3400878906,-247.69491577148],
            "Currys PC World": [374.16693115234,327.72891235352],
            "Dealership": [-33.439804077148,-1097.2783203125],
            "Smurd Hospital": [298.04428100586,-583.97277832031],
            "Police Station": [429.57830810547,-982.27996826172],
        }},
        "Jobs": {category: "jobs", items: {

            "Grass Cutter": [-1050.9725341797,6.0058469772339],
            "Builder": [-848.66363525391,-799.65399169922],
            "Pilot Los Santos": [-1185.2652587891,-2674.0170898438],
            "Pilot Cayo Perico": [4427.7822265625,-4451.53125],
            "Pilot Grapeseed": [2139.9816894531,4788.71484375],
            "Orange Picker": [2031.8020019531,4733.4189453125],
            "Bus Driver": [454.33969116211,-600.66009521484],
            "Fisherman": [5117.67578125,-5190.802734375],
            "Street cleaner": [5117.67578125,-5190.802734375],
            "Mechanic": [-1601.3695068359,-832.49853515625],

        }},
        "Car meet": [859.58813476563,-2364.755859375],
    },

    build() {

        APPS.home.layout.removeClass("visible");

        this.layout.addClass("visible");
    
        this.load();

    },

    load() {
        this.placesList.find(".item").remove();
        this.backBtn.addClass("hidden");

        $.each(this.menuItems, function(k, v) {
            if (v) {

                APPS.gps.placesList.append(`
                    <div ${v.category ? 'data-category="'+ v.category +'"' : 'data-x="'+ v[0] +'" data-y="'+ v[1] +'"'} class="item">
                        <p>${k}</p>
                    </div>
                `)

            }
        });
    },

    ready() {
        this.placesList.on("click", ".item", function(event){
            event.preventDefault();
            var category = $(this).data('category');
            
            if (category) {
                APPS.gps.backBtn.removeClass("hidden");

                APPS.gps.placesList.find(".item").remove();

                var categoryList = APPS.gps.menuItems[$(this).children("p").text()].items;

                $.each(categoryList, function(k, v) {
                    if (v) {
            
                        APPS.gps.placesList.append(`
                            <div ${'data-x="'+ v[0] +'" data-y="'+ v[1] +'"'} class="item sub-category">
                                <p>${k}</p>

                                <div class="location-box">
                                    <i class="bi bi-geo-alt"></i>
                                </div>

                            </div>
                        `)
            
                    }
                });

            } else {
                var x = $(this).data("x");
                var y = $(this).data("y");

                Notifications.show("Position has been set on the map!", 2000);
                post("setMapPosition", [x, y]);

            }
        });

        this.backBtn.on("click", function(event) {
            event.preventDefault();
            APPS.gps.load();
        })
    }

};

APPS.gps.ready();
