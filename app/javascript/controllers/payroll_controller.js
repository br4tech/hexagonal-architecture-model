import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  connect(){  
    var cardToggles = document.getElementsByClassName('card-toggle');
    for (let i = 0; i < cardToggles.length; i++) {
      cardToggles[i].addEventListener('click', e => {
        e.currentTarget.parentElement.parentElement.childNodes[3].classList.toggle('is-hidden');
      });
    } 

    $(".chk_all").on("click", function() {
      console.log("aqui")  
      if (this.checked) {
        $(".checkbox").each(function() {
          this.checked = true;
        });
      } else {
        $(".checkbox").each(function() {
          this.checked = false;
        });
      }
    });
     
    $(".export").on("click", function() {   
      var payrolls = [];

      $(".chk_group:checked").each(function() {
        payrolls.push(this.value);
      });

      $.ajax({
        type: "POST",
        url: "export_payroll",
        data: { payrolls: payrolls },
        success: function(file_content) {
          var blob = new Blob([file_content], { type: "text/plain" });

          var date = new Date();
          var month = date.getMonth() + 1;

          var d = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
          var m = month < 10 ? "0" + month : month;     

          var filename = `CB${d}${m}${Math.floor(Math.random() * 10)}.REM`;

          if (window.navigator.msSaveOrOpenBlob) {
            window.navigator.msSaveBlob(blob, filename);
          } else {
            var elem = window.document.createElement("a");
            elem.href = window.URL.createObjectURL(blob);
            elem.download = filename;
            document.body.appendChild(elem);
            elem.click();
            document.body.removeChild(elem);
          }
        },
        error: function(xhr, textStatus, error) {
          console.log(error);
        }
      });
    });

  }

    // $(".reprocess_payroll").on("click", function(){
    // $('.pageloader').addClass('is-active');
    // $.ajax({
    //   type: "GET",
    //   url: "reprocess_payroll",     
    //   success: function(data){   
    //     $('.pageloader').removeClass('is-active');
    //   },
    //   error: function(xhr, textStatus, error) {
    //     $('.pageloader').removeClass('is-active');
    //   }
    // });
    // });
}