$(document).ready(function(){

  window.addEventListener("message", function(event){
    // Show HUD when player enter a vehicle
    if(event.data.showhud == true){
      $('.main').fadeIn();
      // $('.ugr').fadeIn();
      setProgressSpeed(event.data.speed,event.data.speedn,'#aaass', "#aaass2");
      setEngineHealth(event.data.health,"#aaassc");
    }
    if(event.data.showhud == false){
      $('.main').fadeOut();
      // $('.huds').fadeOut();
      // $('.ugr').fadeOut();
    }

    // // Fuel
    if(event.data.showfuel == true){
      setProgressFuel(event.data.fuel,'#ful');
      // if(event.data.fuel <= 20){
        // $('.progress-fuel').addClass('orangeStroke');
      // }
      // if(event.data.fuel <= 10){
        // // $('.progress-fuel').removeClass('orangeStroke');
        // $('.progress-fuel').addClass('redStroke');
      // }
    }

    // // Lights states
    // if(event.data.feuPosition == false){
    //   document.getElementById("faza").style = `background-image: url(assets/headlight.png); opacity: 0.5;`
    // }
    // if(event.data.feuRoute == false){
    //   document.getElementById("faza").style = `background-image: url(assets/headlight.png); opacity: 0.5;`
    // }
    // if(event.data.feuPosition == true){
    //   document.getElementById("faza").style = `background-image: url(assets/headlight1.png); opacity: 1.0;`
    // }
    // if(event.data.feuRoute == true){
    //   document.getElementById("faza").style = `background-image: url(assets/headlight2.png); opacity: 1.0;`
    // }
    if(event.data.c == 0){
      document.getElementById("faza").style = `background-image: url(assets/headlight.png); opacity: 0.5;`
    } else if(event.data.c == 1) {
      document.getElementById("faza").style = `background-image: url(assets/headlight1.png); opacity: 1.0;`
    } else if(event.data.c == 2) {
      document.getElementById("faza").style = `background-image: url(assets/headlight2.png); opacity: 1.0;`
    }
    if(event.data.clignotantGauche == true){
      document.getElementById("semnals").style = `background-image: url(assets/vectoron.png); opacity: 1.0; animation: inout 1s infinite;`
    }
    if(event.data.clignotantGauche == false){
      document.getElementById("semnals").style = `background-image: url(assets/vector.png); opacity: 0.5;`
    }
    if(event.data.clignotantDroite == true){
      document.getElementById("semnald").style = `background-image: url(assets/vectoron.png); opacity: 1.0; animation: inout 1s infinite;`
    }
    if(event.data.clignotantDroite == false){
      document.getElementById("semnald").style = `background-image: url(assets/vector.png); opacity: 0.5;`
    }


  });

  // Functions
  // Fuel
  function setProgressFuel(percent, element, element2){
    var percent = percent/1.33
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $("#fuel");

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent*73)/100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;

    html.text(Math.round(percent*1.33));
  }

  function setEngineHealth(percent, element){
    var percent = percent
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    // var html = $("#fuel");

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent*73)/100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;

    // html.text(Math.round(percent*1.33));
  }

  // Speed
  function setProgressSpeed(value2,value,element,element2){
    var oldVal = value2;
    var oldVal1 = value;

    // value /= 1.9;
    var stroke = "#F6C863";
    if(value >= 64.5) value = 64.5;
    if(value >= 64.5) stroke = "#D30000";
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $("#kmh");
    var percent = value;

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;
    // circle.style.stroke = stroke
    const offset = circumference - ((-percent*73)/100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;
    value = oldVal1;
    if(value >= 90.0) value = 90.0;
    var circle = document.querySelector(element2);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $("#kmh");
    var percent = value;

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;
    circle.style.stroke = stroke
    const offset2 = circumference - ((-percent*73)/100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset2;
    html.html(oldVal);
  }

  // function setProgressSpeed(value2,value,element){
  //   var oldVal = value2;

  //   // value /= 1.9;
  //   var stroke = "#F6C863";
  //   if(value >= 315) value = 315;
  //   // if(value >= 70) stroke = "#FF3030";
  //   var circle = document.querySelector(element);
  //   var radius = circle.r.baseVal.value;
  //   var circumference = radius * 2 * Math.PI;
  //   var html = $("#kmh");
  //   var percent = value;

  //   circle.style.strokeDasharray = `${circumference} ${circumference}`;
  //   circle.style.strokeDashoffset = `${circumference}`;
  //   // circle.style.stroke = stroke
  //   const offset = circumference - ((-percent*73)/350) / 100 * circumference;
  //   circle.style.strokeDashoffset = -offset;

  //   html.html(oldVal);
  // }

  // setProgress(input.value,element);
  // setProgressFuel(85,'.progress-fuel');
  // setProgressSpeed(124,'.progress-speed');

});
