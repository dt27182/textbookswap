$(document).ready(
	function(){
		$("#course_department").change(
			function(){
				$.getJSON("/course/find_course_numbers", {department : $("#course_department").val()}, function(json){
					$("#course_number").empty();
					$.each(json, function(val){
						$("#course_number").append('<option value="' + val + '">' + val + '</option>');
					});
				});
				$("#main").append("<h1>javascript suceeded</h1>");
			}
		);
	}
);
					
