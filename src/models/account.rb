# frozen_string_literal: true

# The Account class represents a user in the system.
# It includes validations for required attributes and associations
# with games, tests, trivia, and answers. The class also contains
# logic for updating a user's progress.
class Account < ActiveRecord::Base
  validates :name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: 'only allows letters' }
  validates :email, presence: true,
                    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: 'must be a valid email address' }
  validates :password, presence: true, length: { minimum: 8 }
  validates :nickname, presence: true,
                       format: { with: /\A\w+\z/, message: 'only allows letters, numbers, and underscores' }
  validates :progress, presence: true

  has_many :account_games
  has_many :games, through: :account_games
  has_many :account_tests
  has_many :tests, through: :account_tests
  has_many :account_trivias
  has_many :trivias, through: :account_trivias
  has_many :account_answers
  has_many :answers, through: :account_answers

  after_commit :update_progress

  def update_progress
    update_column(:progress, calculate_progress)
  end

  private

  def calculate_progress
    completed_tests_progress + completed_trivias_progress
  end

  def level_progress
    total_levels = Test.distinct.count(:letter)
    total_levels.zero? ? 0 : 100.0 / total_levels
  end

  def completed_tests_progress
    total_tests = Test.distinct.count(:letter)
    completed_tests = account_tests.where(test_completed: true).count
    test_progress = total_tests.zero? ? 0 : level_progress / 2
    completed_tests * test_progress
  end

  def completed_trivias_progress
    total_trivias = Trivia.distinct.count(:test_letter)
    completed_trivias = AccountTrivia.where(trivias_completed: true).count
    trivias_progress = total_trivias.zero? ? 0 : level_progress / (2 * total_trivias)
    completed_trivias * trivias_progress
  end
end
