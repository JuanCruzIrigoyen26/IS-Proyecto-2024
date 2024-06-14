class AccountTest < ActiveRecord::Base
    validates :test_completed, inclusion: { in: [true, false] }
    validates :correct_answers, presence: true

    belongs_to :account
    belongs_to :test

    after_commit :update_progress_account

    private

    def update_progress_account
      account.update_progress
    end
  end
