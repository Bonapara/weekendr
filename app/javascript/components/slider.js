const slider = () => {
  const initGoTimeFrom = document.querySelector('.slider-time').dataset.goTimeFromMinutes;
  const initGoTimeTo = document.querySelector('.slider-time2').dataset.goTimeToMinutes;
  const initReturnTimeFrom = document.querySelector('.return-slider-time').dataset.returnTimeFromMinutes;
  const initReturnTimeTo = document.querySelector('.return-slider-time2').dataset.returnTimeToMinutes;

  $("#slider-range").slider({
      range: true,
      min: 0,
      max: 1440,
      step: 15,
      values: [initGoTimeFrom, initGoTimeTo],
      slide: function (e, ui) {
          var hours1 = Math.floor(ui.values[0] / 60);
          var minutes1 = ui.values[0] - (hours1 * 60);

          if (hours1.length == 1) hours1 = '0' + hours1;
          if (minutes1.length == 1) minutes1 = '0' + minutes1;
          if (minutes1 == 0) minutes1 = '00';
          if (hours1 >= 12) {
              if (hours1 == 12) {
                  hours1 = hours1;
                  minutes1 = minutes1 + " PM";
              } else {
                  hours1 = hours1 - 12;
                  minutes1 = minutes1 + " PM";
              }
          } else {
              hours1 = hours1;
              minutes1 = minutes1 + " AM";
          }
          if (hours1 == 0) {
              hours1 = 12;
              minutes1 = minutes1;
          }



          $('.slider-time').html("<b>" + hours1 + ':' + minutes1 + "</b>");

          var hours2 = Math.floor(ui.values[1] / 60);
          var minutes2 = ui.values[1] - (hours2 * 60);

          if (hours2.length == 1) hours2 = '0' + hours2;
          if (minutes2.length == 1) minutes2 = '0' + minutes2;
          if (minutes2 == 0) minutes2 = '00';
          if (hours2 >= 12) {
              if (hours2 == 12) {
                  hours2 = hours2;
                  minutes2 = minutes2 + " PM";
              } else if (hours2 == 24) {
                  hours2 = 11;
                  minutes2 = "59 PM";
              } else {
                  hours2 = hours2 - 12;
                  minutes2 = minutes2 + " PM";
              }
          } else {
              hours2 = hours2;
              minutes2 = minutes2 + " AM";
          }

          $('.slider-time2').html("<b>" + hours2 + ':' + minutes2 + "</b>");
      }
  });

  $("#return-slider-range").slider({
      range: true,
      min: 0,
      max: 1440,
      step: 15,
      values: [initReturnTimeFrom, initReturnTimeTo],
      slide: function (e, ui) {
          var hours1 = Math.floor(ui.values[0] / 60);
          var minutes1 = ui.values[0] - (hours1 * 60);

          if (hours1.length == 1) hours1 = '0' + hours1;
          if (minutes1.length == 1) minutes1 = '0' + minutes1;
          if (minutes1 == 0) minutes1 = '00';
          if (hours1 >= 12) {
              if (hours1 == 12) {
                  hours1 = hours1;
                  minutes1 = minutes1 + " PM";
              } else {
                  hours1 = hours1 - 12;
                  minutes1 = minutes1 + " PM";
              }
          } else {
              hours1 = hours1;
              minutes1 = minutes1 + " AM";
          }
          if (hours1 == 0) {
              hours1 = 12;
              minutes1 = minutes1;
          }



          $('.return-slider-time').html("<b>" + hours1 + ':' + minutes1 + "</b>");

          var hours2 = Math.floor(ui.values[1] / 60);
          var minutes2 = ui.values[1] - (hours2 * 60);

          if (hours2.length == 1) hours2 = '0' + hours2;
          if (minutes2.length == 1) minutes2 = '0' + minutes2;
          if (minutes2 == 0) minutes2 = '00';
          if (hours2 >= 12) {
              if (hours2 == 12) {
                  hours2 = hours2;
                  minutes2 = minutes2 + " PM";
              } else if (hours2 == 24) {
                  hours2 = 11;
                  minutes2 = "59 PM";
              } else {
                  hours2 = hours2 - 12;
                  minutes2 = minutes2 + " PM";
              }
          } else {
              hours2 = hours2;
              minutes2 = minutes2 + " AM";
          }

          $('.return-slider-time2').html("<b>" + hours2 + ':' + minutes2 + "</b>");
      }
  });
}

  const go_time_fr = document.querySelector('.slider-time');
  const go_time_t = document.querySelector('.slider-time2');
  const return_time_fr = document.querySelector('.return-slider-time');
  const return_time_t = document.querySelector('.return-slider-time2');

  const filter_button = document.querySelector('.research-button-filter');
  const go_time_from = document.getElementById('go_time_from');
  const go_time_to = document.getElementById('go_time_to');
  const return_time_from = document.getElementById('return_time_from');
  const return_time_to = document.getElementById('return_time_to');

  // const go_day = document.getElementById('go_day');

  // const go_d = document.querySelector('.go_d');
  // console.log(go_day);
  // csonsole.log(go_d);
if (filter_button) {
  filter_button.addEventListener("click", function(e) {
    e.preventDefault;
    go_time_from.value = go_time_fr.innerText;
    go_time_to.value = go_time_t.innerText;
    return_time_from.value = return_time_fr.innerText;
    return_time_to.value = return_time_t.innerText;

   });
};

export { slider };
