class Project < ApplicationRecord
  has_many :tasks
  has_many :users, through: :tasks

  validates :name, presence: true

  accepts_nested_attributes_for :tasks

  def self.overdue
    where("due_date < ?", Time.now)
  end

  def self.finished
    Project.all.select do |project|
      project.tasks.all? {|task| task.done == true}
    end
  end

end
