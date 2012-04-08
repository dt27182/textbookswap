function find_course_numbers(){
	$.getJSON("/course/find_course_numbers", {department : $("#course_department").val()}, function(json){
		$("#course_number").empty();
		$.each(json, function(key, val){
			$("#course_number").append('<option value="' + val + '">' + val + '</option>');
		});
	});
}

function find_course_sections(){
	$.getJSON("/course/find_course_sections", 
						{department : $("#course_department").val(), number : $("#course_number").val()},
					 	function(json){
							$("#course_section").empty();
							$.each(json, function(key, val){
								$("#course_section").append('<option value="' + val + '">' + val + '</option>');
								}
							);
						}
	);
}

$(document).ready(
	function(){
		find_course_numbers();
		find_course_sections();
		$("#course_department").change(
			find_course_numbers
		);
		$("#course_number").change(
			find_course_sections
		);
	}
);
					

