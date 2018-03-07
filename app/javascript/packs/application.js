import "bootstrap";
import { slider } from '../components/slider';
import { loadDynamicBannerText } from '../components/banner';
import "jquery-ui/ui/widgets/slider"
import '../components/autocomplete';
import { lowerPriceObserver } from '../components/lowerPrice';


if (document.getElementById("weekends-container-row")) {
 slider();
}

if (document.getElementById("banner-typed-text")) {
 loadDynamicBannerText();
}

if (document.getElementById("weekends-container-row")) {
 lowerPriceObserver();
}
