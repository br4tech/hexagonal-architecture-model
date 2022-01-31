import { Controller } from "@hotwired/stimulus"
import moment from 'moment';

export default class extends Controller {

  static targets = [ "clinic" ];

  connect(){
    $(".cnpj").hide();    
    [...document.getElementsByClassName("is-phone")].forEach(function(el) {
      IMask(el, { mask: "(00) 00000-0000" });
    });

    if($("#reservation_without_contract_client_attributes_kind_1").prop("checked")){
      this.mask(1)
   } else{
      this.mask(2)
   }

   let daysOff = []
      
   fetch('/days_off.json')
     .then(response => response.json())
     .then(data => {
       if(data.length > 0){    
         data.map(function(e){
           daysOff.push(e)
         });
       }
     }) 

   $(".is-date").datepicker({ 
    dateFormat: "dd/mm/yy",
    locale: "pt-br",
    dayNames: [
      "Domingo",
      "Segunda",
      "Terça",
      "Quarta",
      "Quinta",
      "Sexta",
      "Sábado"
    ],
    dayNamesMin: ["D", "S", "T", "Q", "Q", "S", "S", "D"],
    dayNamesShort: ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb", "Dom"],
    monthNames: [
      "Janeiro",
      "Fevereiro",
      "Março",
      "Abril",
      "Maio",
      "Junho",
      "Julho",
      "Agosto",
      "Setembro",
      "Outubro",
      "Novembro",
      "Dezembro"
    ],
    monthNamesShort: [
      "Jan",
      "Fev",
      "Mar",
      "Abr",
      "Mai",
      "Jun",
      "Jul",
      "Ago",
      "Set",
      "Out",
      "Nov",
      "Dez"
    ],
    nextText: "Proximo",
    prevText: "Anterior",       
    beforeShowDay: function setDaysOff(date) {
      for (let i = 0; i <  daysOff.length; i++) {     
        if (date.getFullYear() == moment(daysOff[i].start, "YYYY/MM/DD").format('YYYY')
            && date.getMonth() ==  moment(daysOff[i].start, "YYYY/MM/DD").format('MM') - 1
              && date.getDate() ==  moment(daysOff[i].start, "YYYY/MM/DD").format('DD')) {
            return [false, 'holiday',  daysOff[i].name];          
        }
      }
      return [true, ''];
      },
      onSelect: function(dateText){
        if ($(".is-start").val() != ''){
          $(".is-time").prop( "disabled", false )    
          $(".is-time").timepicker('remove'); 
          
          let hours_not_available_day = []
      
          let office_id =  $('.is-office').val()
          let clinic_id =  $('.is-clinic').val()  
          let start_at =  $('.is-date').val() 
      
          $.ajax({
            type: "POST",
            url: "/reservation_not_available_day",
            data: { 
              office_id: office_id ,      
              clinic_id: clinic_id ,
              start_at: start_at               
            },          
            success: function(data) {  
              hours_not_available_day = []   
             
              if(data.length > 0){         
                data.forEach(el => {
                  hours_not_available_day.push(el)
                });       
                  
                $(".is-time").timepicker({     
                    'timeFormat': 'H:i:s',
                    'minTime': '8',
                    'maxTime': '21',
                    'step': 60,
                    'disableTimeRanges': [hours_not_available_day]               
                  }); 
              }
              else{                      
                $(".is-time").timepicker({     
                  'timeFormat': 'H:i:s',
                  'minTime': '8',
                  'maxTime': '21',
                  'step': 60
                });        
              }        
            },
            error: function(xhr, textStatus, error) {
                console.log(error);
            }
          });    
        }
      }    
  });

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


loadRooms(e) {
  this.clinicTarget.options.length = 0;
  fetch(`/unidades/${e.target.value}.json`)
    .then(response => response.json())
    .then(data => {
      data.clinics.forEach((exp) => {
        this.addSelectOption(exp);       
      })     
      this.loadNotAvailableDays()
    })
}

addSelectOption(data) {
  let _option = document.createElement("option");
  _option.text = `Sala ${data.code}`;
  _option.value = data.id;
  this.clinicTarget.add(_option);
}


 loadNotAvailableDays(){  
  if ($(".is-start").val() != ''){
    $(".is-time").prop( "disabled", false )    
    $(".is-time").timepicker('remove'); 
    
    let hours_not_available_day = []

    let office_id =  $('.is-office').val()
    let clinic_id =  $('.is-clinic').val()  
    let start_at =  $('.is-date').val() 

    $.ajax({
      type: "POST",
      url: "/reservation_not_available_day",
      data: { 
        office_id: office_id ,      
        clinic_id: clinic_id ,
        start_at: start_at               
      },          
      success: function(data) {  
        hours_not_available_day = []   
       
        if(data.length > 0){         
          data.forEach(el => {
            hours_not_available_day.push(el)
          });       
            
          $(".is-time").timepicker({     
              'timeFormat': 'H:i:s',
              'minTime': '8',
              'maxTime': '21',
              'step': 60,
              'disableTimeRanges': [hours_not_available_day]               
            }); 
        }
        else{                      
          $(".is-time").timepicker({     
            'timeFormat': 'H:i:s',
            'minTime': '8',
            'maxTime': '21',
            'step': 60
          });        
        }        
      },
      error: function(xhr, textStatus, error) {
          console.log(error);
      }
    }); 
    $(".is-time").keydown(false);
  }
}

  close(){
    this.element.classList.remove('is-active');
  }

}