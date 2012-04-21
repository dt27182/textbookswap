$(document).ready(function(){
		$.validator.addMethod("integer_price", function(value, element) {
			return this.optional(element) || /^[0-9\_]+$/i.test(value);
		}, "Price must be a whole number.");
    $("#buyer_info_form").validate();
    $("#create_posting_form").validate();
  });
