var currentTask = 0;

class Note {
	constructor(content, user_id, task_id) {
		this.content = content;
		this.user_id = user_id;
		this.task_id = task_id;
	}
	formatNote() {
		$.ajax({
			dataType: "json",
			url: `/users/${this.user_id}`,
			success: (data) => {
				let currentUser = (data.email);
				$(`#${this.task_id}box div`).append(`<p class="comment"><span class="commenter">${currentUser}:</span> ${this.content}</p>`);
			}
		});
	}
}

function addNote(obj) {
	if (event.code == "Enter") {
		let input = obj.value;
		let id = obj.getAttribute('data-id');
		let uid = $('#uid').val();
		let formData = { content: input, user_id: uid, task_id: id}
		let newNote = new Note(input, uid, id);
		$.ajax({
			type: "POST",
			url: "/notes",
			data: formData,
			success: function(data) {
			newNote.formatNote();
			$('.add-note').val('');
			}
		});
	}
}

function deleteProject(obj) {
	let id = parseInt(obj.id);
	$.ajax({
		type: "DELETE",
		url: `/projects/${id}`,
		success: function() {
			$(`#${id}grid-item`).remove();
		}
	});
}

function editTask(obj) {
	let user_id = $(obj).data("user");
	let id = $(obj).data("id");
	currentTask = id;

	let projectId = $(obj).data("project-id");
	
	$('.new-task-form').hide();
	$(`.current-task`).show();
	$(`.add-task`).show();
	$(`.edit-task`).hide();
	$(`.save-button`).hide();
	$(`#${id}assignee select`).val(user_id);

	$(`#${id}task-container`).hide();
	$(`#${id}edit-task-container`).show();
	$(`#${projectId}add-task`).hide();
	$(`#${projectId}save`).show();
}

function hideEditTask(obj) {
	let id = $(obj).data("id");
	let projectId = $(obj).data("project-id");

	$(`.add-task`).show();
	$(`.save-button`).hide();

	$(`#${id}task-container`).show();
	$(`#${id}edit-task-container`).hide();
	$(`#${projectId}add-task`).hide();
	$(`#${projectId}save`).show();

}

function saveTask(obj) {
	let id = parseInt(obj.id);

	if (currentTask) {
	let name = $(`.inner-edit-task-container[data-id=${currentTask}] .edit-task-name`).val() || "New Task";
	let assignee = $(`.inner-edit-task-container[data-id=${currentTask}] .assignee select`).val();
	let date = $(`.inner-edit-task-container[data-id=${currentTask}] .date input`).val();
	let assigneeName = ($(`.inner-edit-task-container[data-id=${currentTask}] .assignee select option:selected`).text());

	var formData = { name: name, user_id: assignee, due_date: date };

		$.ajax({
			type: "PATCH",
			url: `/tasks/${currentTask}`,
			data: formData,
			success: function(data) {
				$(`#${id}edit-marker`).attr('data-user', assignee);
				$(`#${currentTask}edit-task-container`).remove();
				$(`#${currentTask}task-container`).remove();
				$(`#${currentTask}box`).remove();
				var source = document.getElementById("new-task-template").innerHTML;
				var template = Handlebars.compile(source);
				var result = template(data);
				$(`#${currentTask}task-wrapper`).append(result);
				$('.note-box').hide();
				$('.new-task-form').hide();
				$('.edit-task').hide();
				$(`.save-button`).hide();
				$(`.add-task`).show();
				$('.new-task').val('');
			}
		});
	} else {

		let name = $(`#${id}task-name`).val() || "New Task";

		var formData = {
			name: name,
			due_date: $(`#${id}task-date`).val(),
			user_id : $(`#${id}select-user select option:selected`).val(),
			project_id: id
		}
		$.ajax({
			type: "POST",
			url: "/tasks",
			data: formData,
			success: function(data) {
				var source = document.getElementById("task-wrapper").innerHTML;
				var template = Handlebars.compile(source);
				var result = template(data);
				$(`#${id}task-box`).append(result);
				$('.note-box').hide();
				$('.new-task-form').hide();
				$('.edit-task').hide();
				$(`.add-task`).show();
				$(`.save-button`).hide();
				$('.new-task').val('');
			}
		});
	}

}

function displayEditProjectName(obj) {
	let id = $(obj).data("id");

	$(obj).hide();
	$(`#${id}delete-project`).hide();
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
				$(`#${id}delete-project`).show();
				$(`h2[data-id=${id}]`).show();
				$(`h2[data-id=${id}]`).text(input);
			}
		});
}

function retrieveComments(obj) {
		$.ajax({
			dataType: "json",
			url: `/tasks/${parseInt(obj.id)}`,
			success: function(data) {
				var source = document.getElementById("note-template").innerHTML;
				var template = Handlebars.compile(source);
				var result = template(data);
				$(` #${data.id}box div `).html(result);
				$(` #${data.id}box `).slideToggle("slow", function() {	
				});
			}
		});
	}

function showTaskForm(obj) {
	let id = parseInt(obj.id);

	currentTask = 0;

	$('.save-button').hide();
	$('.add-task').show();
	$('.new-task-form').hide();
	$('.edit-task').hide();
	$('.current-task').show();

	$(`#${id}new-task-form`).toggle();
	$(`#${id}add-task`).hide();
	$(`#${id}save`).show();
}

function addProject() {
	$.ajax({
		type: "POST",
		url: "/projects",
		data: {name: "New Project"},
		success: function(data) {
			var source = document.getElementById("new-item-template").innerHTML;
			var template = Handlebars.compile(source);
			var result = template(data);

			$('.grid-row').append(result);
			$('.new-task-form').hide();
			$('.project-name-input').hide();
			$('.save-button').hide();
		}
	});
}

function deleteTask(obj) {
	let id = parseInt(obj.id);
	$.ajax({
		type: "DELETE",
		url: `/tasks/${id}`,
		success: function() {
			$(`#${id}task-container`).remove();
			$(`#${id}box`).remove();
		}
	});
}

function setTaskStatus(obj, done) {
	let id = obj.getAttribute('data-id');
	let status = { done: !done }
	$.ajax({
		type: "PATCH",
		url: `/tasks/${id}`,
		data: status,
		success: function(data) {
			$(`#${id}task`).toggleClass('done');
			obj.removeAttribute('onClick');
			obj.setAttribute('onClick', `setTaskStatus(this, ${!done})`);
		}
	});

}


//Project Sort

function myTasks(){
	$('.hide').hide();
}

function allTasks(){
	$('.current-task').show();
}