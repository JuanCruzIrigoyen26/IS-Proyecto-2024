# frozen_string_literal: true
# The Question class represents a question in the system.
# Each question is associated with multiple possible answers
# and can be part of a test or trivia.

class Question < ActiveRecord::Base
  validates :number, presence: true
  validates :description, presence: true
  validates :test_letter, presence: true

  has_many :answers, foreign_key: 'question_number'
  has_many :account_answers
  belongs_to :test, foreign_key: 'test_letter'
  belongs_to :game, foreign_key: 'game_number'
end
