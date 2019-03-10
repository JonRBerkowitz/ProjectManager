class NotesController < ApplicationController

	def index
		@task = Task.find_by_id(params[:id])
		@notes = @task.notes
		render json: @notes, status: 200
	end

	def create
		note = Note.create(note_params)
    	render json: note, status: 201
	end

	def show
		@note = Note.find_by_id(params[:id])
		render json: @note, status: 200
	end

	private

	def note_params
	   params.permit(:content, :task_id, :user_id)
	end

end
