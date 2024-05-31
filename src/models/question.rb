class Question < ActiveRecord::Base
  validates :number, presence: true
  validates :description, presence: true
  validates :test_letter, presence: true

  has_many :answers, foreign_key: 'question_number'
  has_many :account_answers
  belongs_to :test, foreign_key: 'test_letter'
end

  