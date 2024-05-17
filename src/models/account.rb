class Account < ActiveRecord::Base
  validates :name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :email, presence: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "must be a valid email address" }
  validates :password, presence: true, length: { minimum: 8 }
  validates :nickname, presence: true, format: { with: /\A\w+\z/, message: "only allows letters, numbers, and underscores" }
end
