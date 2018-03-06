function lowerPriceObserver() {
  // Select the node that will be observed for mutations
  var targetNode = document.getElementById('test');

  // Options for the observer (which mutations to observe)
  var config = { childList: true };

  // Callback function to execute when mutations are observed
  var callback = function(mutationsList) {
    for(var mutation of mutationsList) {
      if (mutation.type == 'childList') {
        lowerPrice();
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

function lowerPrice() {
  const prices = document.querySelectorAll('.price');
  const array = [];
  prices.forEach(function(element) {
    const listPrices = element.innerText;
    array.push(listPrices);
  });
  array.sort();
  prices.forEach(function(element) {
    if (element.innerText == array[0]) {
      element.parentNode.classList.add("lower-price");
    } else {
      element.parentNode.classList.remove("lower-price");
    }
  });
}

export { lowerPriceObserver };
