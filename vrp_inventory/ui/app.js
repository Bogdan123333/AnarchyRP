const Inventory = {
    MaxSlots: 44,
    MaxTrunkSlots: 30,
    ChestSlots: 42,
}

var selectedItem = false;
let openItemSelector = (oneItem, itemName, itemDesc, itemWeight, itemAmount, dom) => {
    selectedItem = {
        amount: itemAmount,
        item: oneItem,
        label: itemName,
    };

    let element = $('.iteminfo-container');
    let itemOffset = $(dom).offset();
    element.css('top', itemOffset.top);

    let leftOffset = itemOffset.left + 100;
    if (leftOffset + element.width() > $(window).width()) {
        leftOffset = $(window).width() - element.width() - 20;
    }
    
    element.css('left', leftOffset);
    $("#iteminfo-name").text(itemName); $("#iteminfo-desc").text(itemDesc); $("#iteminfo-weight").text(itemWeight);
}

const isOverflowing = (event, $droppableContainer) => {
    var cTop = $droppableContainer.offset().top;var cLeft = $droppableContainer.offset().left;var cBottom = cTop + $droppableContainer.height();var cRight = cLeft + $droppableContainer.width();
    if (event.pageY >= cTop && event.pageY <= cBottom && event.pageX >= cLeft && event.pageX <= cRight){return false;}else{return true;}
}

async function openInventory(items,totalWeight, maxWeight, refresh, other,PlayerInfo, isInVehicle, NearPlayer) {
    if(!refresh) {
        $('.inventory').fadeIn();
    }

    if (NearPlayer) {
        $("#perchezitioneaza").show();
        $("#strange-armele").hide();
    } else {
        $("#perchezitioneaza").hide();
        $("#strange-armele").show();
    };

    if (isInVehicle) {
        $('#cere-torpedou').show();
        $('#cere-portbagaj').hide();
    } else {
        $('#cere-torpedou').hide();
        $('#cere-portbagaj').show();
    }

    $('.player-inventory').find('.item-box').remove()
    $('.other-inventory').find('.item-box').remove()
    $("#player-kg").text(totalWeight + " / " + maxWeight + " KG");

    var chestProgressbar = (totalWeight / maxWeight) * 100
    if (chestProgressbar > 100) {
        chestProgressbar = 100;
    }

    $(".progress").css("width", chestProgressbar+"%");

    for(i=1; i < Inventory.MaxSlots+13; i++){ // Main Inventory
        $('.player-inventory .player-items').append(`<div data-slot="${i}" class="item-box"></div>`)
    }

    for(i=1; i < (other != undefined && other.isVehicle != true && Inventory.ChestSlots)+1; i++){ // Other Inventory
        $('.other-inventory .other-items').append(`<div data-other-slot="${i}" class="item-box"></div>`)
    }

    for(i=1; i < (other != undefined && other.isVehicle && Inventory.MaxTrunkSlots)+1; i++){ // Other Inventory
        $('.other-inventory .other-items').append(`<div data-other-slot="${i}" class="item-box"></div>`)
    }

    if (other) {
        $('.cloth-inv').fadeOut();
        $('.other-inventory').fadeIn().attr('data-inventory',other.id)
        

        if (other.isVehicle) {
            $('#car-inventory').fadeIn();
            $('.other-inventory-head').text(other.name)
            $(".other-inv-kg").text(other.totalChestWeight + " / " + other.maxChestWeight + " KG")

            $('#chest-inventory').fadeOut();
        } else {
            $('#car-inventory').fadeOut();
            $('.other-inventory').css('top', '20.2vh');
            $('#chest-inventory').fadeIn();

            $("#chest-kg").text(other.totalChestWeight + " / " + other.maxChestWeight + " KG")
            $('#chest-name').text(other.name);

            var chestProgressbar = (other.totalChestWeight / other.maxChestWeight) * 100
            if (chestProgressbar > 100) {
                chestProgressbar = 100;
            }
        
            $(".chest-progress").css("width", chestProgressbar+"%");
        }

        $.each(other.inventory,function(k,v){
            if(v != null){
                $('.inventory').find(`[data-other-slot="${v.slot}"]`).html(`
                    <img src="nui://vrp/gui/item_icons/${v.name}.png">
                    <div class="item-amount">${v.amount}</div>
                `).attr('data-name',v.name).attr('data-label',v.label).attr('data-description',v.description).attr('data-amount', v.amount).attr('data-weight',v.weight)
            }
        })
    } else {
        $('.cloth-inv').fadeIn();
        $('.other-inventory').fadeOut();
    }

    $.each(items,function(k,v){
        if(v != null){
            $('.inventory').find(`[data-slot="${v.slot}"]`).html(`
                <img src="nui://vrp/gui/item_icons/${v.name}.png">
                <div class="item-amount">${v.amount}</div>
            `).attr('data-name',v.name).attr('data-label',v.label).attr('data-description',v.description).attr('data-amount', v.amount).attr('data-weight',v.weight)
        }
    })

    $('.item-box').each(function(){
        if($(this).data('name')){
            if($(this).parent().hasClass('other-items')) {
                $(this).draggable({
                    helper: 'clone',
                    appendTo: ".inventory",
                    revert: 'invalid',
                    containment: 'document',
                })
            } else {
                $(this).draggable({
                    helper: 'clone',
                    appendTo: ".inventory",
                    revert: 'invalid',
                    containment: 'document'
                })
            }
        }
    })    

    $(".item-box").droppable({
        hoverClass: 'button-hover',
        drop: async function(event, ui) {
            if(!isOverflowing(event, $(this).parent().parent()) || $(this).parent().parent().attr('data-inventory') != 'player'){
                var toinventory = $(this).parent().parent().attr('data-inventory')
                var frominventory = ui.draggable.parent().parent().attr('data-inventory')

                let ownedAmm = parseInt(ui.draggable.children(".item-amount").text());
                var amount = 1;

                if (ownedAmm > 1 && (toinventory != frominventory)) {
                    let obj = await Swal.fire({
                        title: ui.draggable.data('label'),
                        text: 'Selecteaza cantitatea',
                        showCancelButton: false,
                        input: 'range',
                        inputAttributes: {min: 1, max: ownedAmm, step: 1},
                        inputValue: 1
                    });
                    amount = parseInt(obj.value);
                }

                if((!isNaN(amount) && amount || 1) > (!isNaN(ownedAmm) && ownedAmm || 1)) {
                    amount = ownedAmm;
                } else if (isNaN(amount)) {
                    return;
                }

                if (amount != 0 && $(this).data('name') == ui.draggable.data('name') || $(this).data('name') == undefined || amount == 0 || isNaN(amount) ){

                    if(frominventory == 'player' && toinventory != 'player'){
                        $.post('https://'+GetParentResourceName()+'/SetInventoryData',JSON.stringify({
                            frominventory: frominventory,
                            toinventory: toinventory,
                            isPlayer: PlayerInfo,
                            item: ui.draggable.data('name'),
                            amount: amount || 1
                        }))
                    } else if(frominventory != 'player' && toinventory == 'player') {
                        $.post('https://'+GetParentResourceName()+'/SetInventoryData',JSON.stringify({
                            frominventory: "other",
                            toinventory: toinventory,
                            isPlayer: PlayerInfo,
                            item: ui.draggable.data('name'),
                            amount: amount || 1
                        }))
                    }
                }
            }
        }
    });

    $('.cloth-items .item-box').off().click(function(){
        $.post('https://'+GetParentResourceName()+'/ChangeVariation', JSON.stringify({ component: $(this).attr('id') }))
    })

    $(".item-amount").each(() => {var t=$(this).html().length;4==t?$(this).css({top:"2vh"}):3==t?$(this).css({top:"2.2vh"}):2==t?$(this).css({top:"2.5vh"}):1==t&&$(this).css({top:"2.7vh"})});
}

const closeInventory = () => {
    $.post('https://'+GetParentResourceName()+'/CloseInventory')
    
    if (selectedItem){
        selectedItem = false;
        $(".iteminfo-container").fadeOut();
    }

    $('.inventory').fadeOut();
}

// Utils

window.addEventListener('message', function(event) {
    switch(event.data.action) {
        case 'openInventory':
            openInventory(event.data.inventory,event.data.totalWeight,event.data.maxWeight, false, event.data.other,event.data.playerData, event.data.isInVehicle, event.data.NearPlayer)
        break;

        case 'close':
            closeInventory();
        break;

        case 'refresh':
            openInventory(event.data.inventory,event.data.totalWeight,event.data.maxWeight, true, event.data.other, event.data.playerData)
        break;
    }
})

$(document).on('keydown', function(event) {
    switch(event.keyCode) {
        case 27: // ESC
            closeInventory()
        break;
    }
}).on("mousedown", ".item-box", function(e) {
    e.preventDefault();
    if (e.which == 3)
    
    {
        if ($(this).data("label") != null) {
            $(".iteminfo-container").fadeIn()
            openItemSelector($(this).data("name"), $(this).data("label"), $(this).data("description"), $(this).data("weight"), $(this).data("amount"), $(this));
        } else {
            selectedItem = false;
            $(".iteminfo-container").fadeOut();
        }
    }

    else if (e.which == 1)
    {
        if (selectedItem)
            selectedItem = false;
            $(".iteminfo-container").fadeOut();
    }
}).on("click", "#item-use", (e) => {
    e.preventDefault();
    if (selectedItem)
         $.post('https://'+GetParentResourceName()+'/UseItem', JSON.stringify({ item: selectedItem.item }));
        selectedItem = false;
        $(".iteminfo-container").fadeOut();
        closeInventory()
}).on("click", "#item-drop", async function(event) {
    event.preventDefault();
    if (selectedItem)
        var amt = 1;
        if (selectedItem.amount > 1){
            $(".iteminfo-container").fadeOut();
            let obj = await Swal.fire({
                title: selectedItem.label,
                text: 'Selecteaza cantitatea aruncata',
                showCancelButton: true,
                input: 'range',
                inputAttributes: {min: 1, max: selectedItem.amount, step: 1},
                inputValue: 1
            });

            amt = parseInt(obj.value);
        } else {
            $(".iteminfo-container").fadeOut();
        }

        if (isNaN(amt)){
            selectedItem = false;
            return;
        }
        $.post('https://'+GetParentResourceName()+'/DropItem', JSON.stringify({ item: selectedItem.item, amount: amt, label: selectedItem.label }));
        closeInventory()
        selectedItem = false;
}).on("click", "#item-give", async function(event) {
    event.preventDefault();
    if (selectedItem)
        var amt = 1;
        if (selectedItem.amount > 1){
            $(".iteminfo-container").fadeOut();
            let obj = await Swal.fire({
                title: selectedItem.label,
                text: 'Selecteaza cantitatea oferita',
                showCancelButton: true,
                input: 'range',
                inputAttributes: {min: 1, max: selectedItem.amount, step: 1},
                inputValue: 1
            });

            amt = parseInt(obj.value);
        } else {
            $(".iteminfo-container").fadeOut();
        }
        if (isNaN(amt)){
            selectedItem = false;
            return;
        }
   
        $.post('https://'+GetParentResourceName()+'/GiveItem', JSON.stringify({ item: selectedItem.item, amount: amt }));
        closeInventory()
        selectedItem = false;
}).on("click", '#ofera-bani', async function(event) {
    event.preventDefault();
    closeInventory()
    $.post('https://'+GetParentResourceName()+'/GiveMoney', JSON.stringify({}));
}).on("click", '#strange-armele', async function(event) {
    event.preventDefault();
    $.post('https://'+GetParentResourceName()+'/StrangeArmele', JSON.stringify({}));
}).on("click", '#cere-portbagaj', async function(event) {
    event.preventDefault();
    $.post('https://'+GetParentResourceName()+'/CerePortbagaj', JSON.stringify({}));
}).on("click", '#cere-torpedou', async function(event) {
    event.preventDefault();
    $.post('https://'+GetParentResourceName()+'/CereTorpedou', JSON.stringify({}));
}).on("click", '#perchezitioneaza', async function(event) {
    event.preventDefault();
    $.post('https://'+GetParentResourceName()+'/Perchezitioneaza', JSON.stringify({}));
});