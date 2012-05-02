$(document).ready(function(){
		$.validator.addMethod("integer_field", function(value, element) {
			return this.optional(element) || /^[0-9\_]+$/i.test(value);
		}, "This field must be a whole number.");
    $("#admin_control_form").validate();
    $("#add_admin_form").validate();
  });
