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
  // resultsFrom.classList.remove("visible");
});

// On ecoute le clic sur la liste de resultats TO
resultsTo.addEventListener('click', (event) => {
  inputTo.value = event.target.innerText;
  iataTo.value = event.target.getAttribute('data-iota');
  resultsTo.innerHTML = '';
  // resultsTo.classList.remove("visible");
});



// Results construction function
const drawResponseList = (data, results) => {
  // On efface les deux listes de resultats
  resultsTo.innerHTML = '';
  resultsFrom.innerHTML = '';
  // On boucle sur les donnes recus de l'API pour afficher une liste de resultats
  data.locations.forEach((location) => {
    let countryCode;
    let icon;
    let country;
    let iota = location.code;
    // Gestion des cas necessaire car les donnees de l'API sont structurees differemment suivant le location.type renvoye
    if (location.type == "country") {
      countryCode = location.code;
      country = "";
    } else if (location.type == "city") {
      countryCode = location.country.code;
      country = location.country.name;
    } else if (location.type == "airport") {
      countryCode = location.city.country.code;
      country = location.city.country.name;
    } else if (location.type == "subdivision") {
      countryCode = location.country.code;
      country = location.country.name;
    } else {
      countryCode = "NF";
      country = "";
    };
    results.insertAdjacentHTML('beforeend',
      `<li class="result" data-iota = "${iota}"> <img src="http://www.countryflags.io/${countryCode}/flat/24.png"> <span class="location-name">${location.name}</span> <span class="country-name">${country}</span></li>`);
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


// Definition des top cities
const topCities = [
  ["Lisbonne", "LIS", "PT", "Portugal"],
  ["Madrid", "MAD", "ES", "Espagne"],
  ["Rome", "ROM", "IT", "Italie"],
  ["Budapest", "BUD", "HU", "Hongrie"]
];



const drawTopCities = () => {
  // On efface les listes de resultats
  resultsTo.innerHTML = '';
  resultsFrom.innerHTML = '';
  // Header destination populaire
  resultsTo.insertAdjacentHTML('beforeend',
  `<li class="top-cities"> <i class="fas fa-star"></i> Destinations populaires </li>`);
  // Boucle sur l'array top cities et creation des li correspondantes
  topCities.forEach((city) => {
    resultsTo.insertAdjacentHTML('beforeend',
      `<li class="result" data-iota = "${city[1]}"> <img src="http://www.countryflags.io/${city[2]}/flat/24.png"> <span class="location-name">${city[0]}</span> <span class="country-name">${city[3]}</span></li>`);
  });
};

// let focus = false;
// Affichage des top cities lorsque le champ "To" est focus par l'utilisateur
inputTo.addEventListener('focus', function(){
  // focus = true;
  // On efface les listes de resultats
  resultsTo.innerHTML = '';
  resultsFrom.innerHTML = '';
  // Header destination populaire
  resultsTo.insertAdjacentHTML('beforeend',
  `<li class="top-cities"> <i class="fas fa-star"></i> Destinations populaires </li>`);
  // Boucle sur l'array top cities et creation des li correspondantes
  topCities.forEach((city) => {
    resultsTo.insertAdjacentHTML('beforeend',
      `<li class="result" data-iota = "${city[1]}"> <img src="http://www.countryflags.io/${city[2]}/flat/24.png"> <span class="location-name">${city[0]}</span> <span class="country-name">${city[3]}</span></li>`);
  });
});




