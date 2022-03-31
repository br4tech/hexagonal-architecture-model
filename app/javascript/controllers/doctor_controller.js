import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect(){
    [...document.getElementsByClassName("is-document")].forEach(function(el) {
      IMask(el, { mask: "000.000.000-00" });
    });    

    [...document.getElementsByClassName("is-phone")].forEach(function(el) {
      IMask(el, { mask: "(00) 00000-0000" });
    });

    var cardToggles = document.getElementsByClassName('card-toggle');
    for (let i = 0; i < cardToggles.length; i++) {
      cardToggles[i].addEventListener('click', e => {
        let count = 3
        let position = e.currentTarget.children[1].value 
        if(position > 0){
          for(let i = 0; i < position; i++){
            count += 4;
          }
        }      
        e.currentTarget.parentElement.parentElement.parentElement.childNodes[count].classList.toggle('is-hidden');
      });
    }
  }
}