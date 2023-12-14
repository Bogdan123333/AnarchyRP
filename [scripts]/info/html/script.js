function displayPluginScreen(toggle) {
	if (toggle) {
		// document.getElementById('main').style.display = 'block';
		$("body","html").show()
	} else {
		$("body","html").hide()
	}
}

$(function(){
	displayPluginScreen(false)

	window.addEventListener('message', function(event) {
		let data = event.data
		switch (data.action) {
			case 'toggleWindow':
				displayPluginScreen(data.value)
			break;
		}
	});

});

document.onkeyup = function (data) {
    if (data.which == 27) {
        displayPluginScreen(false)
		$.post("https://info/forceClose", JSON.stringify());
        return;
    }
};