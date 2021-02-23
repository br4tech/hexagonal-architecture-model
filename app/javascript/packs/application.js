// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require allow_numeric
//= require jquery-ui
//= require jquery-ui-timepicker-addon
//= require jquery
//= require jquery_ujs

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
require("jquery");
require("jquery-ui");
require("chartkick");
require("chart.js");
require("timepicker/jquery.timepicker");
require("jquery-minicolors/jquery.minicolors")
require("jquery-mask-plugin/dist/jquery.mask.js")
require("cocoon")
require("bulma-pageloader")

import { PRONTO } from "./config";
import "controllers"; // Stimulus
import IMask from "imask";

document.addEventListener("turbolinks:load", () => {
  PRONTO.perfum(); // <- Init Plugins
  // Modal
  const _modal_btn = document.getElementById("is-modal-btn");
  if (_modal_btn) {
    _modal_btn.addEventListener("click", function(e) {
      e.preventDefault();
      document.getElementById("modal").classList.add("is-active");
    });
  }

  // Required fields error message
  const _required_fields = document.querySelectorAll("*[required]");
  _required_fields.forEach(function(el) {
    el.setAttribute(
      "oninvalid", 
      "this.setCustomValidity('Campo Obrigatório')"
    );
    el.addEventListener("input", () => {
      if (el.value != "")
        el.setAttribute("oninput", "this.setCustomValidity('')");
    });
  });

  $('.pageloader').addClass('is-active');
  setTimeout(function(){
    $('.pageloader').removeClass('is-active');
  }, 1000) 
})
