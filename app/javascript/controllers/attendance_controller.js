import { Controller } from "@hotwired/stimulus"
import moment from 'moment';

export default class extends Controller {

  static targets = [ "clinic" ];

  connect(){
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

    // jquery-ui
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
        }
    });

  }

  loadRooms(e) {
    this.clinicTarget.options.length = 0;
    fetch(`/unidades/${e.target.value}.json`)
      .then(response => response.json())
      .then(data => {
        data.clinics.forEach((exp) => {
          this.addSelectOption(exp);       
        })     
        this.loadValidateDate()
        this.loadNotAvailableDays()
      })
  }
  
  addSelectOption(data) {
    let _option = document.createElement("option");
    _option.text = `Sala ${data.code}`;
    _option.value = data.id;
    this.clinicTarget.add(_option);
  }

  loadValidateDate(){   
    if($(".control").find(".switch-checkbox:checked").length > 0){
      $(".is-date").prop("disabled", false)
      if ($(".is-start").val() != '' && $(".is-end").val() != ''){    
        $(".is-time").prop( "readonly", false )       
      }else{
        $(".is-time").val('')
        $(".is-time").prop( "readonly", true )
      }
    }else{
      $(".is-date").prop("readonly", true)
    }
  }

  loadNotAvailableDays(){ 
    if ($(".is-start").val() != '' && $(".is-end").val() != ''){
      $(".is-time").prop( "readonly", false )
      $(".is-time").timepicker('remove'); 
       
      let wdays = []
      let hours_not_available = []
      
      $.each($(".switch-checkbox"), function(id, val){
        if($(val).is(":checked")){
          wdays.push($(val).val());
        }
      });

      $.ajax({
        type: "POST",
        url: "/reservation_not_available",
        data: { 
          office_id: $('.is-office').val(),      
          clinic_id: $('.is-clinic').val(),
          start_at: $('.is-start').val(),
          end_at: $('.is-end').val(),
          time_start: $('.is-time-start').val(),
          time_end: $('.is-time-end').val(),
          weekdays: wdays          
        },          
        success: function(data) { 
          hours_not_available = []          
           
          if(data.length > 0){         
            data.forEach(el => {
              hours_not_available.push(el)
            });       
              
            $(".is-time").timepicker({     
                'timeFormat': 'H:i:s',
                'minTime': '8',
                'maxTime': '21',
                'step': 60,
                'disableTimeRanges': [hours_not_available]               
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
}