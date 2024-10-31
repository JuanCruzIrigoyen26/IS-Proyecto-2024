# frozen_string_literal: true

# The AccountTrivia class represents the relationship between
# an account and a trivia. It tracks the trivia games completed
# by a user and their progress within these games.
class AccountTrivia < ActiveRecord::Base
  self.table_name = 'account_trivias'

  validates :trivias_completed, inclusion: { in: [true, false] }

  belongs_to :account
  belongs_to :trivias
  belongs_to :game

  after_commit :update_progress_account

  private

  def update_progress_account
    account.update_progress
  end
end
