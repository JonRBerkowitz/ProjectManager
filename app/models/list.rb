class List < ApplicationRecord
  has_many :list_users
  has_many :users, through: :list_users
  has_many :tasks

  accepts_nested_attributes_for :tasks

  validates :title, presence: true
  validates :due_date, presence: true
end
