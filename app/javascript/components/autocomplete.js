// Search bar, results, and hidden taglist selection
const inputFrom = document.querySelector('#search-from');
const inputTo = document.querySelector('#search-to');
const resultsTo = document.querySelector('#results-to');
const resultsFrom = document.querySelector('#results-from');
const iata = document.querySelector('#iata');



// On ecoute le clic sur la liste de resultats FROM
resultsFrom.addEventListener('click', (event) => {
  // On renseigne la valeur dans le champ du formulaire
  inputFrom.value = event.target.innerText;
  // On insere le code IATA dans un champ cache du formulaire pour le rendre disponible dans les params
  iataFrom.value = event.target.getAttribute('data-iota');
  // On efface la liste de resultats
  resultsFrom.innerHTML = '';
});

// On ecoute le clic sur la liste de resultats TO
resultsTo.addEventListener('click', (event) => {
  inputTo.value = event.target.innerText;
  iataTo.value = event.target.getAttribute('data-iota');
  resultsTo.innerHTML = '';
});



// Results construction function
const drawResponseList = (data, results) => {
  results.innerHTML = '';
  data.locations.forEach((location) => {
    let countryCode;
    let icon;
    let country;
    let iota = location.code;
    // Gestion des cas necessaire car les donnees de l'API sont structurees differemment suivant le location.type renvoye
    if (location.type == "country") {
      countryCode = location.code;
      icon = `<i class="fas fa-globe"></i>`;
      country = "";
    } else if (location.type == "city") {
      countryCode = location.country.code;
      icon = `<i class="fas fa-building"></i>`;
      country = location.country.name;
    } else if (location.type == "airport") {
      countryCode = location.city.country.code;
      icon = `<i class="fas fa-plane"></i>`;
      country = location.city.country.name;
    } else if (location.type == "subdivision") {
      countryCode = location.country.code;
      icon = `<i class="fas fa-globe"></i>`;
      country = location.country.name;
    } else {
      countryCode = "NF";
      icon = `<i class="fas fa-globe"></i>`;
      country = "";
    };
    results.insertAdjacentHTML('beforeend',
      `<li class="result" data-iota = "${iota}"> ${icon} <img src="https://lipis.github.io/flag-icon-css/flags/4x3/${countryCode.toLowerCase()}.svg" alt="flag" style="height:18px;border-radius:2px;"> ${location.name}, ${country}</li>`);
  });
};



// Autocomplete function (to)
const autocompleteTo = (e) => {
  fetch(`https://api.skypicker.com/locations/?term=${e.target.value}&locale=fr-FR&limit=5&sort=population`)
    .then(response => response.json())
    .then(data => drawResponseList(data, resultsTo));
};

// Autocomplete function (from)
const autocompleteFrom = (e) => {
  fetch(`https://api.skypicker.com/locations/?term=${e.target.value}&locale=fr-FR&limit=5&sort=population`)
    .then(response => response.json())
    .then(data => drawResponseList(data, resultsFrom));
};



// Autocomplete function call when search
inputFrom.addEventListener('keyup', autocompleteFrom);
inputTo.addEventListener('keyup', autocompleteTo);

