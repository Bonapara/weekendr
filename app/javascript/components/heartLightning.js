function heartObserver() {
  // Select the node that will be observed for mutations
  var targetNode = document.getElementById('weekends-container-row');
  console.log(targetNode);

  // Options for the observer (which mutations to observe)
  var config = { childList: true };

  // Callback function to execute when mutations are observed
  var callback = function(mutationsList) {
    for(var mutation of mutationsList) {
      if (mutation.type == 'childList') {
        heartLightning();
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

function heartLightning() {
  const keurs = document.querySelectorAll('.fa-heart');
  keurs.forEach(function(keur) {
    keur.addEventListener('click', () => {
      keur.classList.add('fas');
      keur.classList.remove('far');
      keur.classList.add('fa-heart-selected');
    });
  });
}

export { heartObserver };
