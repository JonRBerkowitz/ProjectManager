class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :due_date, :done, :user_id
end
