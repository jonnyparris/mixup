$("#user_email").on('blur', function() {
  var email = $(this);
  var firstName = $('#user_first_name');
  if (!isBlank(email) && isBlank(firstName)) {
    getFirstNameFromEmail(email,firstName);
  };
});

function isBlank (view) {
  return !view.val()
}

function getFirstNameFromEmail (inputBox,outputBox) {
  var email = inputBox.val();
  var firstWordRegex = /\w+/;
  var firstName = firstWordRegex.exec(email)[0];
  outputBox.val(firstName);
}
