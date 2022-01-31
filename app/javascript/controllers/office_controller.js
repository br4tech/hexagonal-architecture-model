import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "clinic" ];

  connect(){
    $(".is-time").timepicker({     
      'timeFormat': 'H:i:s',
      'minTime': '8',
      'maxTime': '21:00pm',
    });

    [...document.getElementsByClassName("is-phone")].forEach(function(el) {
      IMask(el, { mask: "(00) 00000-0000" });
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
      })
  }

  addSelectOption(data) {
    let _option = document.createElement("option");
    _option.text = `Sala ${data.code}`;
    _option.value = data.id;
    this.clinicTarget.add(_option);
  }
}