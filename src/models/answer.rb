# frozen_string_literal: true
# The Answer class represents a possible answer to a question.
# It is part of a collection of options that a user may select.

class Answer < ActiveRecord::Base
  validates :number, presence: true
  validates :description, presence: true
  validates :question_number, presence: true
  validates :test_letter, presence: true

  has_many :account_answers
  has_many :accounts, through: :account_answers
  belongs_to :question, foreign_key: 'question_number'
  belongs_to :test, foreign_key: 'test_letter'
  belongs_to :game, foreign_key: 'game_number'
end
