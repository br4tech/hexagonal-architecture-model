function NumericFieldValidator(data) {
  this.fields = data.fields;
}

NumericFieldValidator.prototype.isValidInput = function(keyCode) {
  return !(keyCode > 31 && (keyCode < 48 || keyCode > 57))
};

NumericFieldValidator.prototype.init = function(data) {
  var _this = this;
  this.fields.keypress(function(event){
    return _this.isValidInput(event.keyCode)
  });
};

$(document).ready(function(){
  var data = {
    fields: $('[data-numeric=true]')
  };
  var validator = new NumericFieldValidator(data);
  validator.init();
});
