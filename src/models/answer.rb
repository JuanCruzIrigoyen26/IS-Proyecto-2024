class answer < ActiveRecord::Base

    validates :number, presence: true
    validates :description, presence: true
    validates :question_number, presence: true
    validates :test_letter, presence: true

    has_many :accounts, through: :account_answers
    has_many :account_answers
    belongs_to :question
    belongs_to :test
end