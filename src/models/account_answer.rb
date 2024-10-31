# frozen_string_literal: true

class AccountAnswer < ActiveRecord::Base
  self.table_name = 'account_answers'
  belongs_to :account
  belongs_to :question
  belongs_to :answer
  belongs_to :game

  after_commit :update_progress_account

  def update_progress_account
    account.update_progress
  end
end
