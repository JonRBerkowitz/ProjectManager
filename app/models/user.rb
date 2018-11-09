class User < ApplicationRecord
  has_many :list_users
  has_many :lists, through: :list_users
  has_many :tasks, through: :lists
end
