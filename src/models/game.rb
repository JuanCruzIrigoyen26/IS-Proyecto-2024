# frozen_string_literal: true

# The Game class represents a game within the system.
# Each game can be associated with multiple user accounts.
class Game < ActiveRecord::Base
  validates :number, presence: true
  validates :name, presence: true
  validates :genre, presence: true

  has_many :tests
  has_many :questions
  has_many :accounts, through: :account_games
  has_many :account_games
end
