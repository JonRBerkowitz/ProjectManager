class Project < ApplicationRecord
  has_many :tasks
  has_many :users, through: :tasks

  validates :name, presence: true

  accepts_nested_attributes_for :tasks

end
