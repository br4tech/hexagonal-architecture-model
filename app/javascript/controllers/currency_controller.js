import { Controller } from "stimulus";

export default class extends Controller {
  format(e) {
    var amount = e.target.value.replace(/[^0-9.]/g, "");
    e.target.value = parseInt(amount).toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
  }
}
