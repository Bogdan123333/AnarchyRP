let cat;

function selectItem(imagem,nome,descriptionItemStores,item,preco) {
	imagem = imagem.replace("|", "");
	if (imagem == "wammoWEAPON_MOLOTOV") {
		imagem = "wbodyWEAPON_MOLOTOV"
	}
	if (imagem == "wammoWEAPON_STICKYBOMB") {
		imagem = "wbodyWEAPON_STICKYBOMB"
	}
	if (imagem == "wammoWEAPON_PIPEBOMB") {
		imagem = "wbodyWEAPON_PIPEBOMB"
	}
	if (imagem.search("scope") != -1) {
		imagem = "luneta";
	}
	if (imagem.search("suppressor") != -1) {
		imagem = "amortizor";
	}
	if (imagem.search("extendedclip") != -1) {
		imagem = "incarcator";
	}
	if (imagem.search("flashlight") != -1) {
		imagem = "lanterna";
	}
	$(".buyStores").fadeIn(500);
	$(".itemStoresz").fadeIn(500);
	$(".itemStores-title").html(nome);
	$(".item-imageStores").html("<img src='images/"+imagem+".png' alt=''>");
	$(".descriptionItemStores").html("<span>"+descriptionItemStores+"</span>");
	$(".priceStores").html("$ "+preco);
	$(".buyStores").attr("data-action", item);
}


function buyItem(){
	let item = $(".buyStores").attr("data-action");
	$.post("http://fpt-scripts/buyStores", JSON.stringify({item: item, name: cat}));
}

$(document).ready(function(){

	function init(item){
		// console.log(JSON.stringify(item))
		$(".item").removeClass("item-focus");
		$(".btnStores").removeClass("btnStores-focus");
		$(".btnStores").text(item.name)
		$(".sectionStores").hide();
		$(".buyStores").hide();
		$(".itemStoresz").hide();
		$("#containerStores").fadeIn(500);
		updateMoney(item.money);
		items = item.items;
		changeCategory(item.name);
	}
	
	function updateMoney(money) {
		let walletStores = money;
		$(".walletStores").html("<i class='fas fa-walletStores' style='color: white;'></i> &nbsp; $ "+walletStores);
	}
	
	function changeCategory(category){
		cat = category
		$(".itemStoresz").fadeOut(500);
		$(".buyStores").fadeOut(500);
		$(".sectionStores-title").html(category);
		$(".itemsStores").html("");
		for (let i = 0; i < items.length; i++) {
			let imagem = items[i].img;
			let nome = items[i].nume;
			let descriptionItemStores = items[i].descriere;
			let item = items[i].item;
			let preco = items[i].pret;
			imagem = imagem.replace("|", "");
			if (imagem == "wammoWEAPON_MOLOTOV") {
				imagem = "wbodyWEAPON_MOLOTOV"
			}
			if (imagem == "wammoWEAPON_STICKYBOMB") {
				imagem = "wbodyWEAPON_STICKYBOMB"
			}
			if (imagem == "wammoWEAPON_PIPEBOMB") {
				imagem = "wbodyWEAPON_PIPEBOMB"
			}
			if (imagem.search("scope") != -1) {
				imagem = "luneta";
			}
			if (imagem.search("suppressor") != -1) {
				imagem = "amortizor";
			}
			if (imagem.search("extendedclip") != -1) {
				imagem = "incarcator";
			}
			if (imagem.search("flashlight") != -1) {
				imagem = "lanterna";
			}
			// if (imagem.search("wammo") != -1) {
			// 	imagem = "ammo";
			// }
			$(".itemsStores").append(
				`<button class='itemStores' onclick='selectItem("`+imagem+`","`+nome+`","`+descriptionItemStores+`","`+item+`","`+preco+`")'>`+
					`<img src='images/`+imagem+`.png' alt=''>`+nome+
				`</button>`
			);
		}
		$(".itemStores").click(function (e) {
			$(".itemStores").removeClass("item-focus");
			$(this).addClass("item-focus");
		})
		$(".sectionStores").fadeIn(500);
		document.querySelector(".itemsStores").scrollTo({top: 0, behavior: 'smooth'});
	}
		
	$(".btnStores").click(function (e) {
		$(".btnStores").removeClass("btnStores-focus");
		$(this).addClass("btnStores-focus");
	})
    window.addEventListener('message', function(event) {
        switch(event.data.action) {
			case "showStores":
				// console.log(JSON.stringify(event.data))
				init(event.data);
				break;
			case "hideStores":
				$("#containerStores").fadeOut(500);;
				break;
        }
    })
});


$(document).on('keydown', function() {
    switch(event.keyCode) {
    	case 27: // ESC
		$.post("http://fpt-scripts/closeStores");
    	break;
    }
});