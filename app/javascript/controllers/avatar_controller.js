import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    $("#avatar").on("change", function() {     
      let r = new FileReader();
      r.onload = function(e) {       
        $(".avatar-preview").show();
        $(".avatar-preview").append("<img class='avatar-preview' src="+ e.target.result+">");
      };
      r.readAsDataURL(this.files[0]);
    });
  }
}
