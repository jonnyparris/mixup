var DependentDatePickersInit = function() {
  var nowTemp = new Date();
  var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);

  var signup = $('#signup_date').fdatepicker({
      format: "dd/mm/yyyy",
      onRender: function (date) {
      return date.valueOf() < now.valueOf() ? 'disabled' : '';
      }
  }).on('changeDate', function (ev) {
      if (ev.date.valueOf() > submission.date.valueOf()) {
          var newDate = new Date(ev.date)
          newDate.setDate(newDate.getDate() + 1);
          submission.update(newDate);
      }
      signup.hide();
      $('#submit_date')[0].focus();
  }).data('datepicker');

  var submission = $('#submit_date').fdatepicker({
      format: "dd/mm/yyyy",
      onRender: function (date) {
          return date.valueOf() <= signup.date.valueOf() ? 'disabled' : '';
      }
  }).on('changeDate', function (ev) {
      submission.hide();
  }).data('datepicker');
}
