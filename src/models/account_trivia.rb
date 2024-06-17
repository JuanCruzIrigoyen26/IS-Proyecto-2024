 class AccountTrivia < ActiveRecord::Base
    self.table_name = 'account_trivias'
    
    validates :trivias_completed, inclusion: { in: [true, false] }

    belongs_to :account
    belongs_to :trivias

    after_commit :update_progress_account

    private

    def update_progress_account
        account.update_progress
    end
 end