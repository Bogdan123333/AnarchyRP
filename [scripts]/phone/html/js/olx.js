

let openedTab = "home";

const olxSearchObj = $("#olx-search");
const olxHeaderObj = $("#olx-header");
const headerTexts = {
	'my': "Anunțurile tale",
	'add': "Adaugă anunț"
};

let olxAddPhotos = [];
let displayAnnounces = [
	// {
	// 	id: 1,
	// 	photos: [],
	// 	title: "Spal Masini",
	// 	price: 5000,
	// 	desc: "Spal multe masini deodata",
	// 	expireDate: 1644338840,
	// 	promoted: false
	// }
];

function nFormatter(num) {
  const lookup = [
    { value: 1, symbol: "" },
    { value: 1e3, symbol: "k" },
    { value: 1e6, symbol: "M" },
    { value: 1e9, symbol: "G" },
    { value: 1e12, symbol: "T" },
    { value: 1e15, symbol: "P" },
    { value: 1e18, symbol: "E" }
  ];
  const rx = /\.0+$|(\.[0-9]*[1-9])0+$/;
  var item = lookup.slice().reverse().find(function(item) {
    return num >= item.value;
  });
  return item ? (num / item.value).toFixed(2).replace(rx, "$1") + item.symbol : "0";
}

function switchTab(newTab) {
	if(newTab !== openedTab) {

		let openObj = $(`#olx-tab-${openedTab}`);
		let newObj = $(`#olx-tab-${newTab}`);

		let animObj = {
			"margin-left": '300px',
			"width": "300%"
	    };

		if(openObj.data("tabindex") < newObj.data("tabindex")) {
			openObj.css({"position": "absolute"});
			animObj = {
				"left": "-300px",
				"margin-right": "300px"
	    	};
		}

		openObj.animate(animObj, function() {

	    	openObj.css({
	    		"margin-left": "inherit",
	    		"margin-right": "inherit",
	    		"left": "0px",
	    		"width": "inherit",
	    		"display": "none",
	    		"position": "inherit"
	    	});
	    	newObj.fadeIn();

	    	openedTab = newTab;

			if(newTab === "home") {
				olxHeaderObj.fadeOut(200, function() {
					olxSearchObj.fadeIn();
				});
			} else {
				olxSearchObj.fadeOut(200, function() {
					olxHeaderObj.fadeIn();
				});

				olxHeaderObj.find("span").text(headerTexts[newTab]);
			}
	    });
	}
}

function toggleDescription(obj) {
	if(obj.nextSibling.style.display == "none") {
		obj.nextSibling.style.display = "block";
		obj.innerHTML = '<i class="fas fa-arrow-up"></i>';
	} else {
		obj.nextSibling.style.display = "none";
		obj.innerHTML = '<i class="fas fa-arrow-down"></i>'
	}
}

let searchQuery;
let loadingScroll = false, noMoreResults = false;

$('#olx-main-container').on('scroll', function() {

	if(openedTab === "results" && !loadingScroll && !noMoreResults) {
		if($(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight - 5) {
			loadingScroll = true;
	        
	        searchQuery.page = (searchQuery.page ? searchQuery.page : 0) + 1;
	        showResults(searchQuery, false);

	        setTimeout(function() {
	        	loadingScroll = false;
	        }, 3000);
	    }
	}
});

function showResults(query, newQuery = true, newSort = false) {

	let resultsTab = $("#olx-tab-results");

	if(!newSort) {
		$("#olx-sort").val("0");
	}

	if(newQuery) {
		$(".olx-obj").remove();
		noMoreResults = false;
	}

	searchQuery = query;

	async function loadResults() {
		$.post("https://phone/olxSearch", JSON.stringify(query), function(results) {

			if(results.length == 0) {
				noMoreResults = true;
			} else {

				let allDivs = [];

				for(let i=0; i<results.length; i++) {

					results[i].id = results[i]['_id'];
					results[i]['_id'] = null;

					let obj = results[i];

					let image = (obj.photos[0] ? obj.photos[0] : "img/olx-default-image.png");

					let div = `<div class="olx-obj ${(obj.promoted ? 'promoted' : '')}" data-id="${obj.id}">
									<div class="olx-row">
										<img src="${obj.photos}">
									</div>
									<div class="olx-row">
										<b class="olx-price"><i class="far fa-dollar-sign"></i> ${nFormatter(obj.price)}</b>
										<div class="olx-title" style="	color: white;">${obj.title}</div>
										<i class="fas fa-phone-alt olx-phone" data-number="${obj.phone}"></i>
										<center class="olx-collapse-btn" onclick="toggleDescription(this);"><i class="fas fas fa-arrow-down"></i></center><div class="olx-desc" style='display: none;'>${obj.desca}</div>
									</div>
								</div>`;

					if(obj.promoted) {
						allDivs.unshift(div);
					} else {
						allDivs.push(div);
					}
				}

				for (var i = 0; i < allDivs.length; i++) {
					resultsTab.append(allDivs[i]);
				}
			}
		});
	}
	
	if(openedTab !== "results") {
		$(`[data-olxfootertab="${openedTab}"]`).removeClass("olx-selected-footer-tab");
		if(openedTab !== "home") {
			olxHeaderObj.fadeOut(200, function() {
				olxSearchObj.fadeIn();
			});
		}

		let openObj = $(`#olx-tab-${openedTab}`);

		openObj.fadeOut(function() {
			loadResults();
			resultsTab.fadeIn();
			openedTab = "results";
		});
	} else {
		loadResults();
	}
}


let promptOpened = false;
let promptObj = $("#olx-prompt");

let cb = closePrompt;

function openPrompt(title, body, cbx = false) {
	if(promptOpened) return;

	if(cbx) cb = cbx;

	promptObj.find(".olx-prompt-title").html(title);
	promptObj.find(".olx-prompt-body").html(body);

	promptObj.show();
	promptObj.animate({top: "4vh"}, function() {
		promptOpened = true;
	});
}

function closePrompt() {
	if(!promptOpened) return;

	promptObj.animate({top: "60vh"}, function() {
		promptObj.hide();
		promptOpened = false;
	});
}
function formatTime(date, inverse = false) {

    let seconds = 0;

    if(inverse) {
        seconds = Math.floor(date - (new Date() / 1000));
    } else {
        seconds = Math.floor((new Date() / 1000) - date)
    }

    let interval = seconds / 2592000;
    if (interval > 1) {
        let d = new Date(date*1000);

        let day = d.getDate();
        if(day < 10) day = "0" + day;

        let month = d.getMonth() + 1;
        if(month < 10) month = "0" + month;

        return day + "." + month + "." + d.getFullYear();
    }
    interval = seconds / 86400;
    if (interval > 1) {
        return Math.floor(interval) + " zile";
    }
    interval = seconds / 3600;
    if (interval > 1) {
        return Math.floor(interval) + " ore";
    }
    interval = seconds / 60;
    if (interval > 1) {
        return Math.floor(interval) + " minute";
    }
    return "Acum";
}
function updateMyAnnounces() {
	$("#olx-tab-my").html("");

	$.post("https://phone/olxFetchMyAnnounces", "{}", function(result) {
		displayAnnounces = result;

		if(displayAnnounces.length >= 1) {
			for (let i = 0; i < displayAnnounces.length; i++) {

console.log(JSON.stringify([displayAnnounces[i]]))

				let obj = displayAnnounces[i];
// <li><i data-toggle="tooltip" data-placement="top" title="Promovează" class="fak fa-increase-line olx-promote-btn"></i></li>
				let image = (obj.photos[0] ? obj.photos[0] : "img/olx-default-image.png");

				let div = `<div class="olx-obj ${(obj.promoted ? 'promoted' : '')}" data-id="${obj.id}">
								<div class="olx-row">
									<img src="${obj.photos}">
								</div>
								<div class="olx-row">
									<b style="color: white;" class="olx-price"><i style="color: white;" class="far fa-dollar-sign"></i> ${nFormatter(obj.price)}</b>
									<div style="color: white;" class="olx-title">${obj.title}</div>
									<div style="color: white;" class="olx-date"><i style="color: white;" class="far fa-clock"></i> ${formatTime(obj.expireDate, true)}</div>
									<ul class="olx-edit-list">
										<li><i data-toggle="tooltip" data-placement="top" title="Editează" class="fas fa-pencil-alt olx-edit-btn"></i></li>
										<li><i data-toggle="tooltip" data-placement="top" title="Șterge" class="fas fa-trash-alt olx-delete-btn"></i></li>
										

									</ul>
								</div>
							</div>`;

				$("#olx-tab-my").append(div);
			}

			$('[data-toggle="tooltip"]').tooltip();
		} else {
			let span = "<center style='color: #888; font-size: 2vh; margin-top: 4vh;'><i class='fas fa-frown'></i><br/>Nu ai nici un anunț</center>";
			$("#olx-tab-my").append(span);
		}

	});
}


$(".olx-app").on("click", ".olx-app-footer-button", function(e) {
	e.preventDefault();

	if(openedTab !== "results") {
		$(`[data-olxfootertab="${openedTab}"]`).removeClass("olx-selected-footer-tab");
	}
	$(this).addClass("olx-selected-footer-tab");

	let newTab = $(this).data("olxfootertab");

	switch(newTab) {
		case "my": 
			updateMyAnnounces();
			break;
	}

	switchTab(newTab);
}).on("mouseenter mouseleave", ".olx-gallery-image", function(e) {
	if(e.type === "mouseenter") {
		
		let delBtn = "<i class='fas fa-times olx-image-btn'>";

		$(this).append(delBtn);

	} else {
		$(".olx-image-btn").remove();
	}
}).on("click", ".olx-image-btn", function(e) {
	e.preventDefault();

	let imageObj = $(this).parent();
	let imageId = imageObj.attr("id");
	let imageNo = parseInt(imageId.charAt(imageId.length - 1));

	olxAddPhotos[imageNo] = null;

	imageObj.css("background-image", "none").removeClass("olx-gallery-image");

}).on("click", ".olx-gallery-obj:not(.olx-gallery-image)", function(e) {
	e.preventDefault();

	let imageId = $(this).attr("id");
	let imageNo = parseInt(imageId.charAt(imageId.length - 1));

	KR.Phone.Functions.Close();
	$.post('https://phone/TakePhoto', "{}", function(url) {
		if(url) {
			for(let i=1; i <= imageNo; i++) {
				if(!olxAddPhotos[i]) {
					imageNo = i;
					imageId = `olx-img-${i}`;
					break;
				}
			}
			$(`#${imageId}`).css("background-image", `url(${url})`).addClass("olx-gallery-image");

			url.substring(1, url.length - 1);
			olxAddPhotos[imageNo] = url;
			KR.Phone.Functions.Open();
		}
	});

	// KR.Phone.Functions.sendPhoto(function(url) {
	// 	if(url) {
	// 		for(let i=1; i <= imageNo; i++) {
	// 			if(!olxAddPhotos[i]) {
	// 				imageNo = i;
	// 				imageId = `olx-img-${i}`;
	// 				break;
	// 			}
	// 		}
	// 		$(`#${imageId}`).css("background-image", `url(${url})`).addClass("olx-gallery-image");

	// 		url.substring(1, url.length - 1);
	// 		olxAddPhotos[imageNo] = url;
	// 	}
	// });


}).on("click", ".olx-gallery-image", function(e) {
	e.preventDefault();

	let imageId = $(this).attr("id");
	let imageNo = parseInt(imageId.charAt(imageId.length - 1));

	if(olxAddPhotos[imageNo]) {
		KR.Screen.popUp(olxAddPhotos[imageNo]);
	}
}).on("input", "textarea", function(e) {
	if((parseInt(this.style.height) ? parseInt(this.style.height) : 0) < this.scrollHeight) {
		this.style.height = (1 + this.scrollHeight) + "px";
	}
}).on("click", "#olx-add-button", function(e) {
	e.preventDefault();

	// check stage

	let category = $("[name='olx-category']").val();

	if(!olxAddPhotos[1]) {
		KR.Phone.Notifications.Add("far fa-times", "Eroare", "Adauga o poza!", "#f22818", 3000);
		return;
	}
	if(!category) {
		KR.Phone.Notifications.Add("far fa-times", "Eroare", "Alege o categorie", "#f22818", 3000);
		return;
	}
	let title = $("[name='olx-title']").val();

	if(!title || title.length < 3) {
		KR.Phone.Notifications.Add("far fa-times", "Eroare", "Scrie un titlu de minim 3 caractere", "#f22818", 3000);
		return;
	}
	if(title.length >= 25) {
		KR.Phone.Notifications.Add("far fa-times", "Eroare", "Scrie un titlu de maxim 25 de caractere", "#f22818", 3000);
		return;
	}

	let price = parseInt($("[name='olx-price']").val());

	if(!price && price >= 0) {
		KR.Phone.Notifications.Add("far fa-times", "Eroare", "Alege un preț de listare", "#f22818", 3000);
		return;
	}

	let desc = $("[name='olx-desc']").val();

	if(!desc || desc.length < 10) {
		KR.Phone.Notifications.Add("far fa-times", "Eroare", "Scrie o descriere de minim 10 caractere", "#f22818", 3000);
		return;
	}
	if(desc.length > 150) {
		KR.Phone.Notifications.Add("far fa-times", "Eroare", "Scrie o descriere de maxim 150 de caractere", "#f22818", 3000);
		return;
	}

	let photos = [];

	for(let i=1; i<=4; i++) {
		if(olxAddPhotos[i]) {
			photos.push(olxAddPhotos[i].substring(1, olxAddPhotos[i].length - 1));
		}
	}
	switchTab("home")
	$.post("https://phone/olxAdd", JSON.stringify({
		category: category,
		title: title,
		price: price,
		desc: desc,
		photos: photos
	}), function(errData) {
		if(errData === false) {
			
			$("[name='olx-category']").val("");
			$("[name='olx-title']").val("");
			$("[name='olx-price']").val("");
			$("[name='olx-desc']").val("");
			for(let i=1; i<=4; i++) {
				if(olxAddPhotos[i]) {
					$(`#olx-img-${i}`).css("background-image", "none").removeClass("olx-gallery-image");
				}
			}
			olxAddPhotos = [];
			updateMyAnnounces();
			
			$("[data-olxfootertab='my']").trigger("click");

		} else {
			KR.Phone.Notifications.Add("far fa-times", errData.title, errData.msg, "#f22818", 3000);
		}
	});

}).on("click", ".olx-row img", function(e) {
	e.preventDefault();
	KR.Screen.popUp($(this).attr("src"));
}).on("click", ".olx-phone", function(e) {
	e.preventDefault();
	KR.Phone.Functions.writeNumberInDial($(this).data("number"));
}).on("click", ".olx-edit-btn", function(e) {
	e.preventDefault();

	let objElement = $(this).parents(".olx-obj")[0];

	for(let i=0; i<displayAnnounces.length; i++) {
		let obj = displayAnnounces[i];

		if(obj.id == objElement.dataset.id) {

			openPrompt("<i class='fas fa-pencil-alt'></i> Editează anunț", `<div class="olx-form-area">

				<label>Titlu</label>
				<input type="text" name="olx-title" maxlength="25" value="${obj.title}" />

				<label>Preț</label>
				<input type="number" name="olx-price" min="0" value="${obj.price}" />

				<label>Descriere</label>
				<textarea name="olx-desc" rows="9" maxlength="150">${obj.desc}</textarea>

				<div onclick="cb();" class="olx-btn">
					<i class="fas fa-check"></i> Salvează
				</div>
				<div onclick="closePrompt();" class="olx-btn">
					<i class="fas fa-times"></i> Anulează
				</div>
			</div>`, () => {
				
				let formArea = $(".olx-form-area");

				let newTitle = formArea.find("[name='olx-title']").val();
				if(!newTitle || newTitle.length < 3) {
					KR.Phone.Notifications.Add("far fa-times", "Eroare", "Scrie un titlu de minim 3 caractere", "#f22818", 3000);
					return;
				}
				if(newTitle.length >= 25) {
					KR.Phone.Notifications.Add("far fa-times", "Eroare", "Scrie un titlu de maxim 25 de caractere", "#f22818", 3000);
					return;
				}

				let newPrice = parseInt(formArea.find("[name='olx-price']").val());
				if(!newPrice && newPrice >= 0) {
					KR.Phone.Notifications.Add("far fa-times", "Eroare", "Alege un preț de listare", "#f22818", 3000);
					return;
				}

				let newDesc = formArea.find("[name='olx-desc']").val();
				if(!newDesc || newDesc.length < 10) {
					KR.Phone.Notifications.Add("far fa-times", "Eroare", "Scrie o descriere de minim 10 caractere", "#f22818", 3000);
					return;
				}
				if(newDesc.length > 150) {
					KR.Phone.Notifications.Add("far fa-times", "Eroare", "Scrie o descriere de maxim 150 de caractere", "#f22818", 3000);
					return;
				}
				closePrompt();
				updateMyAnnounces();
				$.post("https://phone/olxEditAnn", JSON.stringify({
					id: obj.id,
					title: newTitle,
					price: newPrice,
					desc: newDesc
				}), function(errData) {
					if(errData === false) {
						updateMyAnnounces();
						closePrompt();
					} else {
						KR.Phone.Notifications.Add("far fa-times", errData.title, errData.msg, "#f22818", 3000);
					}
				});
			});

			break;
		}
	}
	
}).on("click", ".olx-delete-btn", function(e) {
	e.preventDefault();

	let objElement = $(this).parents(".olx-obj")[0];

	for(let i=0; i<displayAnnounces.length; i++) {
		let obj = displayAnnounces[i];

		if(obj.id == objElement.dataset.id) {

			openPrompt("<i class='fas fa-trash-alt'></i> Șterge anunț", `<div class="olx-form-area">

				Ești sigur că dorești să ștergi acest anunț ?

				<br/>
				<div onclick="cb();updateMyAnnounces();closePrompt();" class="olx-btn">
					<i class="fas fa-check"></i> Șterge
				</div>
				<div onclick="closePrompt();" class="olx-btn">
					<i class="fas fa-times"></i> Anulează
				</div>
			</div>`, () => {
				
				$.post("https://phone/olxDeleteAnn", JSON.stringify({
					id: obj.id
				}), function(errData) {
					if(errData === false) {
						updateMyAnnounces();
						closePrompt();
					} else {
						KR.Phone.Notifications.Add("far fa-times", errData.title, errData.msg, "#f22818", 3000);
					}
				});

			});

			break;
		}
	}	
}).on("click", ".olx-promote-btn", function(e) {
	e.preventDefault();

	let objElement = $(this).parents(".olx-obj")[0];

	for(let i=0; i<displayAnnounces.length; i++) {
		let obj = displayAnnounces[i];

		if(obj.id == objElement.dataset.id) {

			openPrompt("<i class='fak fa-increase-line'></i> Promovează anunț", `<div class="olx-form-area">

				Anunțul tău va fi afișat preferențial.<br/>
				Prețul unei promovări este de <b>$50.000</b> pe 24 de ore.<br/>
				<div onclick="cb();" class="olx-btn">
					<i class="fas fa-check"></i> Plătește
				</div>
				<div onclick="closePrompt();" class="olx-btn">
					<i class="fas fa-times"></i> Anulează
				</div>
			</div>`, () => {
				
				if(!obj.promoted) {
					$.post("https://phone/olxPromoteAnn", JSON.stringify({
						id: obj.id
					}), function(errData) {
						if(errData === false) {
							updateMyAnnounces();
							closePrompt();
						} else {
							KR.Phone.Notifications.Add("far fa-times", errData.title, errData.msg, "#f22818", 3000);
						}
					});
				} else {
					KR.Phone.Notifications.Add("fas fa-smile-beam", "URA!", "Anunțul tău este deja promovat", "#07db2a", 3000);
				}
				

			});

			break;
		}
	}	
}).on("click", ".olx-extend-btn", function(e) {
	e.preventDefault();

	let objElement = $(this).parents(".olx-obj")[0];

	for(let i=0; i<displayAnnounces.length; i++) {
		let obj = displayAnnounces[i];

		if(obj.id == objElement.dataset.id) {

			openPrompt("<i class='fak fa-increase-line'></i> Prelungește anunț", `<div class="olx-form-area">

				Anunțul tău va fi prelungit pentru încă 3 zile.<br/>
				Prețul unei extinderi este de <b>$10.000</b>.<br/>
				<div onclick="cb();" class="olx-btn">
					<i class="fas fa-check"></i> Plătește
				</div>
				<div onclick="closePrompt();" class="olx-btn">
					<i class="fas fa-times"></i> Anulează
				</div>
			</div>`, () => {
				
				$.post("https://phone/olxExtendAnn", JSON.stringify({
					id: obj.id
				}), function(errData) {
					if(errData === false) {
						updateMyAnnounces();
						closePrompt();
					} else {
						KR.Phone.Notifications.Add("far fa-times", errData.title, errData.msg, "#f22818", 3000);
					}
				});

			});

			break;
		}
	}	
}).on("change", "#olx-sort", function(e) {
	let value = $(this).val();

	if(searchQuery) {
		if(value == 0) {
			searchQuery.sortPrice = null;
		} else {
			searchQuery.sortPrice = parseInt(value);
		}
		searchQuery.page = 0;
		showResults(searchQuery, true, true);
	}
});