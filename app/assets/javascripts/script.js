function addNote(obj) {
	if (event.code == "Enter") {
		let input = obj.value;
		let id = obj.getAttribute('data-id');
		let uid = $('#uid').val();
		let formData = { content: input, user_id: uid, task_id: id}

		$.ajax({
			type: "POST",
			url: "/notes",
			data: formData,
			success: function(data) {
			var source = document.getElementById("new-note-template").innerHTML;
			var template = Handlebars.compile(source);
			var result = template(data);
			$(`#${id}box div`).append(result);
			$('.add-note').val('');
			}
		});
	}
}

function deleteProject(obj) {
	let id = parseInt(obj.id);
	console.log(id);
	$.ajax({
		type: "DELETE",
		url: `/projects/${id}`,
		success: function() {
			$(`#${id}grid-item`).remove();
		}
	});
}

function displayEditProjectName(obj) {
	let id = $(obj).data("id")

	console.log($(`#${id}delete`));

	$(obj).hide();
	$(`#${id}delete`).hide();
	$(`.project-name-input[data-id=${id}]`).show();
}

function editProjectName(obj) {
	if (event.code == "Enter") {
		saveProjectName(obj);	
	}	
}

function saveProjectName(obj) {
	let id = $(obj).data("id")

	input = $(`.project-name-input[data-id=${id}]`).val();

	formData = { name: input }

	$.ajax({
			type: "PATCH",
			url: `/projects/${id}`,
			data: formData,
			success: function(data) {
				$(obj).hide();
				$(`#${id}delete`).show();
				$(`h2[data-id=${id}]`).show();
				$(`h2[data-id=${id}]`).text(input);
			}
		});
}
