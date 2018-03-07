import "bootstrap";
import { loadDynamicBannerText } from '../components/banner';
import "jquery-ui/ui/widgets/slider"
import { slider } from '../components/slider';
import '../components/autocomplete';
import { lowerPriceObserver } from '../components/lowerPrice';
import { higherPriceObserver } from '../components/higherPrice';

if (document.getElementById("banner-typed-text")) {
 loadDynamicBannerText();
}

if (document.querySelector(".slider-time")) {
 slider();
}

if (document.getElementById("weekends-container-row")) {
 lowerPriceObserver();
}

if (document.getElementById("weekends-container-row")) {
 higherPriceObserver();
}
