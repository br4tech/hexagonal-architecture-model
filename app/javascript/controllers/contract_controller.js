import { Controller } from "@hotwired/stimulus"
export default class extends Controller {

   connect(){
      $(".cnpj").hide();  
      $(".is-address").prop("readonly", true);
      if($("#contract_client_attributes_kind_1").prop("checked")){
         this.mask(1)
      } else{
         this.mask(2)
      }
      
      [...document.getElementsByClassName("is-amount")].forEach(function(el) {
         IMask(el, {
           mask: "R$ num",
           blocks: {
             num: {
               mask: Number,
               scale: 2,
               signed: false,
               padFractionalZeros: true, 
               normalizeZeros: true,
               radix: ',',         
               thousandsSeparator: ".",          
             }
           }
         });
       });
   }

   loadAddress(e){   
     let cep = $('.is-zipcode').val() 
     
     $(".is-address").each(function(){
        this.value = "";
     });

     fetch(`https://viacep.com.br/ws/${cep.replace("-","")}/json/`)
      .then(response => response.json())
      .then(data => {
         if(data != ''){   
          $(".is-street").val(`${data.logradouro}`)         
          $(".is-complement").val(`${data.complemento}`)
          $(".is-neighborhood").val(`${data.bairro}`)         
          $(".is-city").val(`${data.localidade}`);
          $(".is-state").val(`${data.uf}`);
         }
      })
   }

   kind_people(e){    
     this.mask(e.target.value)
   }  
      
   mask(kind){
      if(kind == 1){
         $(".is-document-2").mask('999.999.999-99');        
         $(".cnpj").hide();
         $(".cpf").show(); 
      }else{
         $(".is-document-2").mask('99.999.999/9999-99');         
         $(".cpf").hide();
         $(".cnpj").show();
      }
   }
}