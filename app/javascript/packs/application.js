import "bootstrap";
import { loadDynamicBannerText } from '../components/banner';
import "jquery-ui/ui/widgets/slider"
import { slider } from '../components/slider';
import '../components/autocomplete';
import { lowerPriceObserver } from '../components/lowerPrice';
import { higherPriceObserver } from '../components/higherPrice';
import { otherPriceObserver } from '../components/otherPrice';
import {heartObserver} from '../components/heartLightning';


if (document.getElementById("banner-typed-text")) {
 loadDynamicBannerText();
}

if (document.querySelector(".slider-time")) {
 slider();
}

if (document.getElementById("weekends-container-row")) {
 lowerPriceObserver();
 heartObserver();
}

if (document.getElementById("weekends-container-row")) {
 higherPriceObserver();
}

if (document.getElementById("weekends-container-row")) {
 otherPriceObserver();
}
