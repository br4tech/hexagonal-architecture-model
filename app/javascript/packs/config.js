import moment from 'moment';

export const PRONTO = {  

  perfum() {    
    // Masks
    [...document.getElementsByClassName("is-document")].forEach(function(el) {
      IMask(el, { mask: "000.000.000-00" });
    });    

    [...document.getElementsByClassName("is-phone")].forEach(function(el) {
      IMask(el, { mask: "(00) 00000-0000" });
    });

    [...document.getElementsByClassName("is-time")].forEach(function(el) {
      IMask(el, {
        overwrite: true,
        autofix: true,
        mask: "HH:MM",
        blocks: {
          HH: {
            mask: IMask.MaskedRange,
            placeholderChar: "HH",
            from: 0,
            to: 23,
            maxLength: 2
          },
          MM: {
            mask: IMask.MaskedRange,
            placeholderChar: "MM",
            from: 0,
            to: 59,
            maxLength: 2
          }
        }
      });
    });

    // $(".is-color").minicolors();

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

    let checked = $("#contract_kind_1").prop("checked") || $("#contract_kind_2").prop("checked")

    if(checked){
      $(".kind-private").hide();
    }

    $("#contract_kind_0").on("click", function() {
      $(".kind-private").show();
    });

    $("#contract_kind_1").on("click", function() {
      $(".kind-private").hide();
    });

    $("#contract_kind_2").on("click", function() {
      $(".kind-private").hide();
    });
  }
};
