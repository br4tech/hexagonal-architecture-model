import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  connect(){  
    var cardToggles = document.getElementsByClassName('card-toggle');

    for (let i = 0; i < cardToggles.length; i++) {
      cardToggles[i].addEventListener('click', e => {
        let count = 3
        let position = e.currentTarget.children[0].value 
        if(position > 0){
          for(let i = 0; i < position; i++){
            count += 4;
          }
        }    
        e.currentTarget.parentElement.parentElement.parentElement.parentElement.parentElement.childNodes[count].classList.toggle('is-hidden');
      });
    } 

    var chk_all = document.getElementsByClassName('chk_all');

    for (let i = 0; i < chk_all.length; i++) {
      chk_all[i].addEventListener('click', e => {   
        let count = 3
        let position = e.currentTarget.parentElement.childNodes[3].value
        if(position > 0){
          for(let i = 0; i < position; i++){
            count += 4;
          }
        }        
        var items = e.currentTarget.parentElement.parentElement.parentElement.parentElement.childNodes[count].childNodes[1]
       
        for (var i = 0; i < items.childElementCount; i++) {
          if(i %2 == 1) {
            var chk = items.childNodes[i].childNodes[1].childNodes[1].childNodes[1]
            if(chk.checked){
              chk.checked = false
            } else {
              chk.checked = true
            }
          }
        }
      });
    }
  }
}