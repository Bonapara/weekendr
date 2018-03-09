function allPriceObserver() {
  // Select the node that will be observed for mutations
  var targetNode = document.getElementById('weekends-container-row');
  console.log(targetNode);

  // Options for the observer (which mutations to observe)
  var config = { childList: true };

  // Callback function to execute when mutations are observed
  var callback = function(mutationsList) {
    for(var mutation of mutationsList) {
      if (mutation.type == 'childList') {
        allPrice();
      }
    }
  };

  // Create an observer instance linked to the callback function
  var observer = new MutationObserver(callback);

  // Start observing the target node for configured mutations
  observer.observe(targetNode, config);

  // Later, you can stop observing
  // observer.disconnect();
}


function allPrice() {
  const prices = document.querySelectorAll('.price');
  const array = [];
  prices.forEach(function(element) {
    const listPrices = element.innerText;
    array.push(parseInt(listPrices));
  });

  array.sort(function (a, b) {  return a - b;  });

  // console.log(prices);
  // console.log('ici');
  // console.log(array);
  //console.log(array[0].parentNode);
  // console.log('la');
  //console.log(array[array.length - 1].parentNode);
  const strip_classes = function(element){
    element.parentNode.classList.remove("lower-price");
    element.parentNode.classList.remove("lowprice");
    element.parentNode.classList.remove("mediumprice");
    element.parentNode.classList.remove("highprice");
  };

  prices.forEach(function(element) {
    switch (parseInt(element.innerText)) {
    case array[0]:
      strip_classes(element);
      element.parentNode.classList.add("lower-price");
      break;
    case array[1]:
      strip_classes(element);
      element.parentNode.classList.add("lowprice");
      break;
    case array[2]:
      strip_classes(element);
      element.parentNode.classList.add("lowprice");
      break;
    case array[array.length - 1]:
      strip_classes(element);
      element.parentNode.classList.add("highprice");
      break;
    default:
      strip_classes(element);
      element.parentNode.classList.add("mediumprice");
      }

  });
}


export { allPriceObserver };



// if (parseInt(element.innerText) == array[1]) {
//     element.parentNode.classList.add("other-lowprice");
// } else if (parseInt(element.innerText) == array[2]) {
//     element.parentNode.classList.add("other-lowprice");
// } else if (parseInt(element.innerText) == array[3]) {
//     element.parentNode.classList.add("other-mediumlowprice");
//     } else if (parseInt(element.innerText) == array[4]) {
//     element.parentNode.classList.add("other-mediumlowprice");
//     } else if (parseInt(element.innerText) == array[5]) {
//     element.parentNode.classList.add("other-mediumlowprice");
//     } else if (parseInt(element.innerText) == array[6]) {
//     element.parentNode.classList.add("other-mediumlowprice");
//     } else if (parseInt(element.innerText) == array[7]) {
//     element.parentNode.classList.add("other-mediumlowprice");
//     } else if (parseInt(element.innerText) == array[8]) {
//     element.parentNode.classList.add("other-mediumlowprice");
//     } else if (parseInt(element.innerText) == array[9]) {
//     element.parentNode.classList.add("other-mediumhighprice");
// } else {
//     element.parentNode.classList.add("other-highprice");
// }
