
const transferGrid = $("#bank-transfer-grid");

KR.Phone.Functions.setupBankApp = function() {
	$.post("https://phone/GetBankMoney", "{}", function(amount) {
		$("#bank-balance").html(amount + "<span> USD</span>");		
	});

	let row = 1;
	$(".bank-contact:not([data-bank-number=new])").remove();
	$.each(KR.Phone.Data.Contacts || [], function(i, contact) {
		row = (row % 3) + 1;

		let div = `<div class="bank-contact" data-row='${row}' data-bank-number="${contact.number}">
						<div class="bank-contact-side">
							<img class="bank-contact-picture" src='https://test.lux.sc/api/smekerie/fetchAvatar.php?p=${contact.number}'/>
							<span>${contact.name}</span>
						</div>
						<div class="bank-contact-side" style="display: none;">
							<input type="number" name="amount" placeholder="Sumă" />
							<div class="bank-btn"><i class="fa-solid fa-paper-plane"></i> Trimite</div>
						</div>
					</div>`;

		transferGrid.append(div);
	});
}


let bankAnimDuration = 400, bankModifiedObjects = [], bankCanAnimate = true;

async function revertAnimations(cb = () => {}) {
	if(bankModifiedObjects.length > 0) {

		let obj = $(bankModifiedObjects[0]);

		let defaultWidth = bankModifiedObjects[3];
		let defaultMargin = bankModifiedObjects[4];

		obj.find(".bank-contact-side:nth-child(2)").fadeOut();
		obj.animate({"margin-left": defaultMargin, "width": defaultWidth + "px"}, () => {
			let obj1 = bankModifiedObjects[1], obj2 = bankModifiedObjects[2];

			obj.css({"margin-left": '0', "width": "auto", "grid-column-end": parseInt(obj.data("row") + 1)});
			
			obj1.css({"opacity": ''}).fadeIn();
			obj2.css({"opacity": ''}).fadeIn();

			bankModifiedObjects = [];

			obj.removeClass("selected");

			cb();
		});
	} else {
		cb();
	}
}

$('#bank-transfer-grid').on("click", ".bank-btn", function(e) {
	if(KR.Phone.Data.currentApplication === "bank") {
	
		let contactObj = $(this).parent().parent();
		let toNumber = contactObj.attr("data-bank-number");

		if(toNumber == "new") {
			toNumber = $(this).prev().prev().val();
		}

		if(bankCanAnimate) {
			if(toNumber && toNumber.length > 0) {

				let amount = $(this).prev().val();

				if(amount && amount > 0) {
					bankCanAnimate = false;
					revertAnimations(() => {

						bankCanAnimate = true;
						
						$.post("https://phone/transferMoney", JSON.stringify({
							number: toNumber,
							amount: amount
						}));
						setTimeout(function() {
							$.post("https://phone/GetBankMoney", "{}", function(amount) {
								$("#bank-balance").html(amount + "<span> USD</span>");		
							});
						}, 1500);
					});
				} else {
					KR.Phone.Notifications.Add("fas fa-exclamation-circle", "Flash Bank", "Defineste o sumă");
				}

			} else {
				KR.Phone.Notifications.Add("fas fa-exclamation-circle", "Flash Bank", "Defineste un destinatar");
			}
		}
		
	}
}).on("click", ".bank-contact", function(e) {
	if(KR.Phone.Data.currentApplication === "bank") {
		e.stopPropagation();

		if(this == bankModifiedObjects[0]) return;

		if(!bankCanAnimate) return;
		bankCanAnimate = false;
		
		revertAnimations(() => {
			let currWidth = $(this).width();
			let objRow = parseInt(this.dataset.row);
			let obj1, obj2;

			switch(objRow) {
				case 1:
					obj1 = $(this).next();
					obj2 = $(this).next().next();
					break;

				case 2:
					obj1 = $(this).prev();
					obj2 = $(this).next();
					break;

				case 3:
					obj1 = $(this).prev();
					obj2 = $(this).prev().prev();
					break;
			}

			obj2.animate({"opacity": 0}, bankAnimDuration);
			obj1.animate({"opacity": 0}, bankAnimDuration); 

			setTimeout(() => {
				obj2.hide().css({"opacity": ''});
				obj1.hide().css({"opacity": ''});

				$(this).css({"grid-column-end": "span 3", "width": currWidth, "margin-left": "calc(" + (objRow-1) + "vh + " + (objRow-1)*currWidth + "px)"});

				$(this).addClass("selected");

				let currMargin = $(this).css("margin-left");
				bankModifiedObjects = [this, obj1, obj2, currWidth, currMargin];

				$(this).animate({"width": "100%", "margin-left": "0"});
				setTimeout(() => {
					$(this).find(".bank-contact-side:nth-child(2)").fadeIn();
					setTimeout(() => {
						bankCanAnimate = true;
					}, 500);
				}, 10);


			}, bankAnimDuration);
		});
	}
});


$(window).click(function() {
	if(KR.Phone.Data.currentApplication === "bank") {
		if(bankCanAnimate) {
			bankCanAnimate = false;
			revertAnimations(() => {
				bankCanAnimate = true;
			});
		}
	}
});