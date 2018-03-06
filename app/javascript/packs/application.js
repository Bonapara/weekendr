import "bootstrap";
import { loadDynamicBannerText } from '../components/banner';
import "jquery-ui/ui/widgets/slider"
import { slider } from '../components/slider';
import '../components/autocomplete';
import { cardObserver } from '../components/linkCardsToRecap';
import { lowerPriceObserver } from '../components/lowerPrice';

if (document.getElementById("banner-typed-text")) {
 loadDynamicBannerText();
}

if (document.querySelector(".slider-time")) {
 slider();
}

if (document.getElementById("test")) {
 lowerPriceObserver();
 cardObserver();
}
