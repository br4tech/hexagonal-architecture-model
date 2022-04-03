import { Controller } from "@hotwired/stimulus"
import { Calendar } from "@fullcalendar/core";
import moment from 'moment';
import interactionPlugin from '@fullcalendar/interaction'; // for selectable
import dayGridPlugin from "@fullcalendar/daygrid";
import timeGridPlugin from '@fullcalendar/timegrid';

export default class extends Controller {
  static targets = ["expertises", "errors"];
  
  connect() {   

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

    const calendar = new Calendar(this.element, {
      locale: "pt-br",
      plugins: [interactionPlugin, dayGridPlugin, timeGridPlugin],
      header: {
        left: "prev,next",
        center: "title",
        right: "dayGridMonth,timeGridWeek,timeGridDay"
      },

      buttonText: {
        month: "Mensal",
        week: "Semanal",
        day: "Diário"
      },

      views: {
        dayGridMonth: {
          displayEventEnd: true
        }
      },

      selectable: false,
      selectHelper: true,
      editable: false,
      eventLimit: true,
      eventSources: [
        '/reservations.json', 
        '/reservation_without_contracts.json'       
      ], 

      eventRender: function(info) {     
        info.el.setAttribute("data-remote", "true")
      },

      dayRender: function (dayRenderInfo) {
        let date = dayRenderInfo.date

        for (let i = 0; i <  daysOff.length; i++) {     
          if (date.getFullYear() == moment(daysOff[i].start, "YYYY/MM/DD").format('YYYY')
              && date.getMonth() ==  moment(daysOff[i].start, "YYYY/MM/DD").format('MM') - 1
                && date.getDate() ==  moment(daysOff[i].start, "YYYY/MM/DD").format('DD')) {
            dayRenderInfo.el.setAttribute("style", `background-color: ${daysOff[i].color}`);
            dayRenderInfo.el.append(daysOff[i].name)                
          }
        }      
      }
    });   
    calendar.render();  
    // $(".fc-buttomReservationWithoutContract-button").attr("data-remote", "true")
  }
}