# frozen_string_literal: true

# AccountTest represents the relationship between an account and a test,
# tracking tests completed by a user and their progress.
class AccountTest < ActiveRecord::Base
  validates :test_completed, inclusion: { in: [true, false] }
  validates :correct_answers, presence: true

  belongs_to :account
  belongs_to :test
  belongs_to :game

  after_commit :update_progress_account

  private

  def update_progress_account
    account.update_progress
  end
end
