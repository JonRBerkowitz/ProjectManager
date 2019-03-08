class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :notes

  accepts_nested_attributes_for :notes

  validates :name, presence: true
  validates :due_date, presence: true
end
