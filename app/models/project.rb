class Project < ApplicationRecord
  has_many :tasks
  has_many :users, through: :tasks

  validates :name, presence: true
  validates :due_date, presence: true

  accepts_nested_attributes_for :tasks

  def self.overdue
    where("due_date < ?", Time.now)
  end
end
