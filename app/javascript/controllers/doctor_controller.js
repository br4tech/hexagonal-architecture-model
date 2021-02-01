import { Controller } from "stimulus";

export default class extends Controller {
  connect(){
    [...document.getElementsByClassName("is-document")].forEach(function(el) {
      IMask(el, { mask: "000.000.000-00" });
    });    

    [...document.getElementsByClassName("is-phone")].forEach(function(el) {
      IMask(el, { mask: "(00) 00000-0000" });
    });
  }
}