class User < ApplicationRecord
  has_secure_password

  has_many :list_users
  has_many :lists, through: :list_users
  has_many :tasks, through: :lists

  validates :username, :presence => true
  validates :username, :uniqueness => true
  validates :username, length: { in: 6..32 }

  validates :password, length: { in: 8..32 }
end
