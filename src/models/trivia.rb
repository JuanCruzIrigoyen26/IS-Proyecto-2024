# frozen_string_literal: true

class Trivia < ActiveRecord::Base
  self.table_name = 'trivias'

  validates :number, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :test_letter, presence: true
  validates :mode, presence: true

  has_many :accounts, through: :account_trivias
  has_many :account_trivias
  belongs_to :test, foreign_key: 'test_letter'
  belongs_to :game, foreign_key: 'game_number'
end
