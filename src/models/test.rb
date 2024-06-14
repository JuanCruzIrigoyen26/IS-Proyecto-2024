class Test < ActiveRecord::Base
    self.primary_key = 'letter'
    validates :letter, presence: true
    validates :description, presence: true
    validates :cant_questions, presence: true

    has_many :trivias, foreign_key: 'test_letter', primary_key: 'letter'
    has_many :questions
    has_many :answers
    has_many :accounts, through: :account_tests
    has_many :account_tests
    belongs_to :game, foreign_key: 'game_number'
end


  