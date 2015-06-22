$("#password-toggle").on('click', function() {
  togglePasswordVisibility($("#user_password"),this.checked);
});

function togglePasswordVisibility (inputs, shouldBeVisible) {
  inputs.toggleClass('password').toggleClass('string')
  togglePasswordType(inputs, shouldBeVisible);
}

function togglePasswordType (inputFields, shouldBeVisible) {
  for (var i = 0; i < inputFields.length; i++) {
    if (shouldBeVisible) {
      inputFields[i].removeAttribute('type','password');
      inputFields[i].setAttribute('type','text');
    } else {
      inputFields[i].removeAttribute('type','text');
      inputFields[i].setAttribute('type','password');
    }
  }
};
