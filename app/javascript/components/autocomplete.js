// Search bar, results, and hidden taglist selection
const inputFrom = document.querySelector('#search-from');
const inputTo = document.querySelector('#search-to');
const resultsTo = document.querySelector('#results-to');
const resultsFrom = document.querySelector('#results-from');
const iataFrom = document.querySelector('#iataFrom');
const iataTo = document.querySelector('#iataTo');


if (document.querySelector("#results-from") !== null) {
  // On ecoute le clic sur la liste de resultats FROM
  resultsFrom.addEventListener('click', (event) => {
    let e;
    // Condition pour que l'event soit toujours le même mm si le user clique partout comme un teubé
    if (event.target.parentNode.id == "results-from") {
      e = event.target;
    } else {
      e = event.target.parentNode;
    };
    // On renseigne la valeur dans le champ du formulaire
    inputFrom.value = e.getAttribute('data-display');
    // On insere le code IATA dans un champ cache du formulaire pour le rendre disponible dans les params
    iataFrom.value = e.getAttribute('data-iota');
    // On efface la liste de resultats
    resultsFrom.innerHTML = '';
    // resultsFrom.classList.remove("visible");
  });

  // On ecoute le clic sur la liste de resultats TO
  resultsTo.addEventListener('click', (event) => {
    let e;
    if (event.target.parentNode.id == "results-to") {
      e = event.target;
    } else {
      e = event.target.parentNode;
    };
    inputTo.value = e.getAttribute('data-display');
    iataTo.value = e.getAttribute('data-iota');
    resultsTo.innerHTML = '';
    // resultsTo.classList.remove("visible");
  });

  // body.addEventListener('click', (event) => {
  //   // On efface les deux listes de resultats
  //   resultsTo.innerHTML = '';
  //   resultsFrom.innerHTML = '';
  // });

  resultsTo.addEventListener('mouseleave', () => {
    resultsTo.innerHTML = '';
  });

  resultsFrom.addEventListener('mouseleave', () => {
    resultsFrom.innerHTML = '';
  });



}


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
    let toDisplay;
    // let locationName = location.name;
    // Gestion des cas necessaire car les donnees de l'API sont structurees differemment suivant le location.type renvoye
    if (location.type == "country") {
      countryCode = location.code;
      country = "";
      toDisplay = location.name;
    } else if (location.type == "city") {
      countryCode = location.country.code;
      country = ", " + location.country.name;
      toDisplay = location.name + ", " + location.country.name;
      // country = "Tous les aéroports";
    } else if (location.type == "airport") {
      countryCode = location.city.country.code;
      country = ", " + location.city.country.name;
      toDisplay = location.city.name + " (" + location.code + ")";
    } else if (location.type == "subdivision") {
      countryCode = location.country.code;
      country = ", " + location.country.name;
      toDisplay = location.name + ", " + location.country.name;
    } else {
      countryCode = "NF";
      country = "";
    };
    results.insertAdjacentHTML('beforeend',
      `<li class="result" data-iota = "${iota}" data-display = "${toDisplay}" > <img src="https://lipis.github.io/flag-icon-css/flags/4x3/${countryCode.toLowerCase()}.svg" alt="flag" style="height:18px;border-radius:2px;"> <span class="location-name">${location.name}</span><span class="country-name">${country}</span></li>`);
  });
};


// <img src="https://lipis.github.io/flag-icon-css/flags/4x3/${city[2].toLowerCase()}.svg" alt="flag" style="height:18px;border-radius:2px;">
// <img src="https://lipis.github.io/flag-icon-css/flags/4x3/${countryCode.toLowerCase()}.svg" alt="flag" style="height:18px;border-radius:2px;">


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


if (document.querySelector("#search-from") !== null) {
// Autocomplete function call when search
  inputFrom.addEventListener('keyup', autocompleteFrom);
  inputTo.addEventListener('keyup', autocompleteTo);
}

// Definition des top cities
const topCities = [
  ["Lisbonne, ", "LIS", "PT", "Portugal"],
  ["Madrid, ", "MAD", "ES", "Espagne"],
  ["Rome, ", "ROM", "IT", "Italie"],
  ["Budapest, ", "BUD", "HU", "Hongrie"]
];



// const drawTopCities = () => {
//   // On efface les listes de resultats
//   resultsTo.innerHTML = '';
//   resultsFrom.innerHTML = '';
//   // Header destination populaire
//   resultsTo.insertAdjacentHTML('beforeend',
//   `<li class="top-cities"> <i class="fab fa-child"> </i> Destinations populaires </li>`);
//   // Boucle sur l'array top cities et creation des li correspondantes
//   topCities.forEach((city) => {
//     resultsTo.insertAdjacentHTML('beforeend',
//       `<li class="result" data-iota = "${city[1]}" > <img src="https://lipis.github.io/flag-icon-css/flags/4x3/${city[2].toLowerCase()}.svg" alt="flag" style="height:18px;border-radius:2px;"> <span class="location-name">${city[0]}</span> <span class="country-name">${city[3]}</span></li>`);
//   });
// };

if (document.querySelector("#search-to") !== null) {
  // Affichage des top cities lorsque le champ "To" est focus par l'utilisateur
  inputTo.addEventListener('focus', function(e) {
    // On efface les listes de resultats
    resultsTo.innerHTML = '';
    // Header destination populaire
    resultsTo.insertAdjacentHTML('beforeend',
    `<li class="top-cities"> <i class="fas fa-heart"></i> Destinations populaires </li>`);
    // Boucle sur l'array top cities et creation des li correspondantes
    topCities.forEach((city) => {
      resultsTo.insertAdjacentHTML('beforeend',
        `<li class="result" data-iota = "${city[1]}" data-display = "${city[0] + city[3]}" > <img src="https://lipis.github.io/flag-icon-css/flags/4x3/${city[2].toLowerCase()}.svg" alt="flag" style="height:18px;border-radius:2px;"> <span class="location-name">${city[0]}</span> <span class="country-name">${city[3]}</span></li>`);
    });
  });
}


