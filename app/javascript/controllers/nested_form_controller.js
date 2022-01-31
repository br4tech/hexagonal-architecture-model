import { Controller } from "@hotwired/stimulus"
import { PRONTO } from "../packs/config";

export default class extends Controller {
  static targets = ["links", "template"];

  connect() {
    this.wrapperClass = this.data.get("wrapperClass") || "nested-fields";
    this._index = this.data.get("index");
  }

  add_association(event) {
    event.preventDefault();
    var content = this.templateTarget.innerHTML.replace(
      /NEW_RECORD/g,
      new Date().getTime()
    );
    this.linksTarget.insertAdjacentHTML("beforebegin", content);
    this.rebindPerfum();
  }

  remove_association(event) {
    event.preventDefault();
    let wrapper = event.target.closest("." + this.wrapperClass);

    if (wrapper.dataset.newRecord == "true") {
      wrapper.remove();
    } else {
      wrapper.querySelector("input[name*='_destroy']").value = 1;
      wrapper.style.display = "none";
    }
  }

  rebindPerfum() {
    PRONTO.perfum();
  }
}
