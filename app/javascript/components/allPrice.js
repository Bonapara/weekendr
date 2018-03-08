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
  prices.forEach(function(element) {
    switch (parseInt(element.innerText)) {
    case array[0]:
        element.parentNode.classList.add("lower-price");
        break;
    case array[1]:
        element.parentNode.classList.add("lowprice");
        break;
    case array[2]:
        element.parentNode.classList.add("lowprice");
        break;
    case array[3]:
        element.parentNode.classList.add("mediumprice");
        break;
    case array[4]:
        element.parentNode.classList.add("mediumprice");
        break;
    case array[5]:
        element.parentNode.classList.add("mediumprice");
        break;
    case array[6]:
        element.parentNode.classList.add("mediumprice");
        break;
    case array[7]:
        element.parentNode.classList.add("mediumprice");
        break;
    case array[8]:
        element.parentNode.classList.add("mediumprice");
        break;
    case array[9]:
        element.parentNode.classList.add("highprice");
        break;
    case array[10]:
        element.parentNode.classList.add("highprice");
        break;
    case array[array.length - 1]:
        element.parentNode.classList.add("higher-price");
        break;
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
