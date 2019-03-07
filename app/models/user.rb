class User < ApplicationRecord
  has_secure_password

  has_many :tasks
  has_many :projects, through: :tasks
  has_many :notes
  
  validates :email, presence: true
  validates :email, uniqueness: true

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_format_of :email, with: EMAIL_REGEX

end
