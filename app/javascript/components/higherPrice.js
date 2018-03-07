
function higherPriceObserver() {
  // Select the node that will be observed for mutations
  var targetNode = document.getElementById('weekends-container-row');
  console.log(targetNode);

  // Options for the observer (which mutations to observe)
  var config = { childList: true };

  // Callback function to execute when mutations are observed
  var callback = function(mutationsList) {
    for(var mutation of mutationsList) {
      if (mutation.type == 'childList') {
        higherPrice();
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

function higherPrice() {
  const prices = document.querySelectorAll('.price');
  const array = [];
  prices.forEach(function(element) {
    const listPrices = element.innerText;
    array.push(parseInt(listPrices));
  });
  array.sort(function (a, b) {  return a - b;  });
    console.log(array);
  prices.forEach(function(element) {
    if (parseInt(element.innerText) == array[11]) {
      element.parentNode.classList.add("higher-price");
    } else {
      element.parentNode.classList.remove("higher-price");
    }
  });
}

export { higherPriceObserver };