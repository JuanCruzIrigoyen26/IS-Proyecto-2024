# frozen_string_literal: true

require File.expand_path('../models/init', __dir__)

describe AccountTrivia do
  context 'validations' do
    it 'is valid with valid attributes' do
      account_trivia = AccountTrivia.new(trivias_completed: false, account_id: 4, trivias_id: 2)
      expect(account_trivia).to be_valid
    end

    it 'is not valid without a complete value' do
      account_trivia = AccountTrivia.new(trivias_completed: nil)
      expect(account_trivia).not_to be_valid
    end
  end
end
