window.addEventListener("message", function(e) {
    const data = e.data;
    if (data.action = 'openMenuBanking') {
        $("#ibana").text(data.iban || "Neidentificat");
        $("#bal").text("$" + (data.balance || "0"));
        $('.bankingContainer').fadeIn();
    }
});

function retrage(amount) {
    $('.bankingContainer2').fadeOut();
    $.post(`https://${GetParentResourceName()}/bank`, JSON.stringify({
        type: 'retragere',
        amount: amount
    }));
    updateInfo()
}

function depune(amount) {
    $('.bankingContainer2').fadeOut();
    $.post(`https://${GetParentResourceName()}/bank`, JSON.stringify({
        type: 'depunere',
        amount: amount
    }));
    updateInfo()
}

const titles = {
    depunere: {
        title: 'Depunere',
        desc: 'Scrie suma pe care vrei sa o depui.'
    },
    retragere: {
        title: 'Retragere',
        desc: 'Scrie suma pe care vrei sa o retragi.'
    },
    transfer: {
        title: 'Transfer',
        desc: 'Scrie suma pe care vrei sa o transferi si iban-ul.'
    }
}

let actMenu = null;

function closeSecondMenu() {
    actMenu = null;
    $("#iban").hide();
    $('.bankingContainer2').fadeOut();
}

function cont() {
    $.post(`https://${GetParentResourceName()}/bank`, JSON.stringify({
        type: actMenu,
        amount: $("#amt").val(),
        id: $("#iban").val()
    }));
    closeSecondMenu();
    actMenu = null;
    $("#iban").hide();
    updateInfo()
}

function closeMenu() {
    $.post(`https://${GetParentResourceName()}/close`);
    $('.bankingContainer2').fadeOut();
    $('.bankingContainer').fadeOut();
}

function updateInfo() {
    $.post(`https://${GetParentResourceName()}/getBalance`, "{}", function(balance) {
        $("#bal").text("$" + balance)
    });
}

function openReq(req) {
    actMenu = req;
    if (req == 'transfer') {
        $("#iban").show()
    }
    $("#title").text(titles[req].title)
    $("#desc").text(titles[req].desc)
    $('.bankingContainer2').fadeIn()
}

document.onkeyup = function(data) {
    if (data.which == 27) {
        closeMenu();
    }
};