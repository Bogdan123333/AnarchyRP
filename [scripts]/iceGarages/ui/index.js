function selected(ce, brr) {
    $.post('https://iceGarages/spawnvehicle', JSON.stringify({ veh: ce, plate: brr }));
}

$( document ).ready(function() {
    function display(bool) {
        if (bool) {

            $("body, html").fadeIn(500);
        } else {
            $("body, html").fadeOut(500);
        }
    }


    display(false)


    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
                masini = item.masini

                $(".masini_content").append('')
                $(".masini_content").html('')
                

                for (var k in masini) {
                    $(".masini_content").append(
                        ` 
                          
                        <div class="car_main">
                        <h2>${item.masini[k][0]}</h2>
                        <div class="car_data">
                           <p><i class="fas fa-gauge"></i> ${item.masini[k][3]} km / h</p>
                           <p><i class="fa fa-id-card"></i> ${item.masini[k][1]}</p>
                        </div>
                        <div onclick="selected('${item.masini[k][2]}','')">
                        <div class="spawn-button">SELECT</div>
                   </div>
                   <img src="${item.masini[k][4]}" alt="">   
                   </div>  
                        
                              `);
                }
            } else {
                display(false)
            }
        }
    })
    
    


    document.onkeyup = function (data) {

        

     if (data.which == 27) {
                    $.post('http://iceGarages/exit', JSON.stringify({})); 
 
            return
        }


    };

});







