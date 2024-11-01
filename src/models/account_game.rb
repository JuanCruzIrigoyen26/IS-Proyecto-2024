# frozen_string_literal: true
# The AccountGame class represents the relationship between an
# account and a game. This model is used to track the games
# associated with a user within the system.

class AccountGame < ActiveRecord::Base
  validates :account_knowledge, presence: true
  belongs_to :account
  belongs_to :game
end
