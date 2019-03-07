class NotesController < ApplicationController

	def index
		@task = Task.find_by_id(params[:id])
		@notes = @task.notes
		render json: @notes, status: 200
	end

	def show
		@note = Note.find_by_id(params[:id])
		render json: @note, status: 200
	end

end
