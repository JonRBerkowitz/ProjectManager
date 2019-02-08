class Project < ApplicationRecord
  has_many :tasks
  has_many :users, through: :tasks

  validates :name, presence: true
  validates :due_date, presence: true
end
