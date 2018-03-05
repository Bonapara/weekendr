import "bootstrap";
import { loadDynamicBannerText } from '../components/banner';
import "jquery-ui/ui/widgets/slider"
import { slider } from '../components/slider';
import '../components/autocomplete';
import { autocomplete } from '../components/lowerPrice';
autocomplete();
import '../components/lowerPrice';
import { lowerPrice } from '../components/lowerPrice';
lowerPrice();

if (document.getElementById("banner-typed-text")) {
  loadDynamicBannerText();
}

if (document.querySelector(".slider-time")) {
  slider();
}
