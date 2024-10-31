# frozen_string_literal: true

# AccountGame represents the relationship between an account and a game,
# used to track games associated with a user in the system.
class AccountGame < ActiveRecord::Base
  validates :account_knowledge, presence: true
  belongs_to :account
  belongs_to :game
end
