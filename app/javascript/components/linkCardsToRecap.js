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
  const cards = document.querySelectorAll('.card');

  cards.forEach(function(card) {
    card.addEventListener('mouseenter', (event) => {
      const date = event.currentTarget.dataset.from;
      const timelineDate = document.querySelector("[data-from='" + date + "']");
      timelineDate.classList.add("selected-date");
    });

    card.addEventListener('mouseleave', (event) => {
      const date = event.currentTarget.dataset.from;
      const timelineDate = document.querySelector("[data-from='" + date + "']");
      timelineDate.classList.remove("selected-date");
    });
  });
}

export { cardObserver };
