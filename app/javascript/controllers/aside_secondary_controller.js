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
    var chk_selected = [];

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
        var items_dup = items.childElementCount * 2       
  
        if(e.currentTarget.checked){         
          for (var i = 0; i < items_dup; i++) {
            if(i %2 == 1) {
              var chk = items.childNodes[i].childNodes[1].childNodes[1].childNodes[1]                  
              chk.checked = true
              chk_selected.push(chk.value);              
            }
          }
        }else{        
          for (var i = 0; i < items_dup; i++) {
            if(i %2 == 1) {
              var chk = items.childNodes[i].childNodes[1].childNodes[1].childNodes[1]                  
              chk.checked = false
              chk_selected.push(chk.value);              
            }
          }
        }        
      });

      $(".chk").on("click", function(e) {
        let hdf = $(`.hdf_${e.currentTarget.value }`).val()
        if(!e.currentTarget.checked){
          for(let i = 0; i < chk_selected.length; i++){    
            if ( chk_selected[i] === e.currentTarget.value) {     
                chk_selected.splice(i, 1); 
            }           
          }
          if(chk_selected.length == 0){  
            $(`.chk_${hdf}`).prop('checked',false) 
          }
        }else{         
          $(`.chk_${hdf}`).prop('checked',true)
        }             
      });      
    }
  }
}