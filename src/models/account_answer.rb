class AccountAnswer < ActiveRecord::Base
    belongs_to :account
    belongs_to :answer
    belongs_to :question
  
    after_commit :update_progress_account
  
    private
  
    def update_progress_account
      account.update_progress
    end
  end