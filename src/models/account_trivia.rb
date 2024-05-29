 class AccountTrivia < ActiveRecord::Base
    validates :trivia_completed, inclusion: { in: [true, false] }
    validates :correct_questions, presence: true

    belongs_to :account
    belongs_to :trivia

    after_commit :update_progress_account

    private

    def update_progress_account
        account.update_progress
    end
 end