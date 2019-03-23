class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :due_date, :done, :user_id, :project_id
  belongs_to :user
  has_many :notes
end
