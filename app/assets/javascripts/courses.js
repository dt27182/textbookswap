$("#course_department").change(function(){
	$.getJSON(
		"/course/find_course_numbers", 
		{department: $("#course_department").val()},
		function(json){
			$("#course_department").empty()
			$.each(json, function(val)){
				$("#course_department").append('<option value="' + val + '">' + val + '</option>');
			};	
		}
	);
};
		
