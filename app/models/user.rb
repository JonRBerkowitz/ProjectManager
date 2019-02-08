class User < ApplicationRecord
  has_secure_password

  has_many :list_users
  has_many :lists, through: :list_users
  has_many :tasks, through: :lists

  validates :email, :presence => true
  validates :email, :uniqueness => true

end
