import { Controller } from "@hotwired/stimulus"
import { controllers } from "chart.js";

export default class extends Controller {
  static targets = [ "query", "result" ]

  connect() {
    this.url = new URL(this.data.get("url"))
  }
  
  // disconnect() {
  //   this.reset()
  // }
  
  autocomplete() {
    const _self = this;

    if(this.query == "") {      
      this.reset()
      return
    }

    if(this.query == this.previousQuery) return
    this.previousQuery = this.query
    
    this.url.searchParams.append("query", this.query)
    this.abortPreviousFetchRequest()
    this.abortController = new AbortController()

    $(this.queryTarget).autocomplete({
      source: function(_, response) {
        fetch(_self.url, { signal: _self.abortController.signal })
          .then(response => response.json())
          .then(data => { response(data) })
          .catch((err) => { console.error(err) })
      },
      minLength: 2,
      select: function(_, ui) {
        _self.redirectTo(ui.item);
      }
    });

  }

  // private

  redirectTo(record) {
    let _page = new URL(window.location.href)

    _page.searchParams.append("client_id", record.id);
    window.location = _page.href; 
  }

  setSelected(record) {   
    controllers.log(record)
    this.resultTarget.value = record.id;
    this.queryTarget.value = record.name;

    document.querySelectorAll('[data-field]')
      .forEach(el => {
        let field = el.dataset.field
        if (el) {
          el.value = record[field];
          el.disabled = true
        }
      });
  }

  reset() {
    this.resultTarget.value = ""
    this.queryTarget.value = ""
    this.previousQuery = null
  }
  
  get query() {
    return this.queryTarget.value
  }

  abortPreviousFetchRequest() {
    if(this.abortController) {
      this.abortController.abort()
    }
  }
}