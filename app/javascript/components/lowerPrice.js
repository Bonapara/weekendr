function lowerPrice() {
  const prices = document.querySelectorAll('.price');
  const array = [];
  prices.forEach(function(element) {
    const listPrices = element.innerText;
    array.push(listPrices);
  });
  console.log(array.sort());
  prices.forEach(function(element) {
    if (element.innerText == array[0]) {
      element.parentNode.classList.add("lower-price");
    };
  });
}

export { lowerPrice };
