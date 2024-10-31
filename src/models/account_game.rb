# frozen_string_literal: true

class AccountGame < ActiveRecord::Base
  validates :account_knowledge, presence: true
  belongs_to :account
  belongs_to :game
end
