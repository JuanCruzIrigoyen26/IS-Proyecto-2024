class AccountGame < ApplicationRecord
    enum account_knowledge: { basic: 'basic', medium: 'medium', advance: 'advance' }

    validates :account_knowledge, presence: true
    belongs_to :account
    belongs_to :game
  
    validates :account_knowledge, presence: true, inclusion: { in: %w[basic medium advance] }
  end
  