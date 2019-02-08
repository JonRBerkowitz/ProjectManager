class List < ApplicationRecord
  has_many :list_users
  has_many :users, through: :list_users
  has_many :tasks
  def self.overdue
    where("due_date < ?", Time.now)
  end
  accepts_nested_attributes_for :tasks
    accepts_nested_attributes_for :users


  validates :title, presence: true
  validates :due_date, presence: true
end