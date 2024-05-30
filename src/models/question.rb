class Question < ActiveRecord::Base

    validates :number, presence: true
    validates :description, presence: true
    validates :test_letter, presence: true

    belongs_to :test, foreign_key: 'test_letter'
    has_many :answers, through: :account_answers
    has_many :account_answers
end