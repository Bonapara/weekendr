function cardObserver() {
  // Select the node that will be observed for mutations
  var targetNode = document.getElementById('test');

  // Options for the observer (which mutations to observe)
  var config = { childList: true };

  // Callback function to execute when mutations are observed
  var callback = function(mutationsList) {
    for(var mutation of mutationsList) {
      if (mutation.type == 'childList') {
        linkCardsToRecap();
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

function linkCardsToRecap() {
  const card = document.querySelectorAll('.card-body');
  card.forEach(function(element) {
    element.addEventListener('mouseover', () => {
    console.log('coucou');
    });
  });
}

export { cardObserver };
