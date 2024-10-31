# frozen_string_literal: true

require File.expand_path('../models/init', __dir__)

describe Trivia do
  context 'validations' do
    it 'is valid with valid attributes' do
      trivia = Trivia.new(number: 1, title: 'Introduction', description: 'Esto es una trivia valida', test_letter: 'A',
                          mode: 'casual')
      expect(trivia).to be_valid
    end

    it 'is not valid without a number' do
      trivia = Trivia.new(number: nil)
      expect(trivia).not_to be_valid
    end

    it 'is not valid without a title' do
      trivia = Trivia.new(title: nil)
      expect(trivia).not_to be_valid
    end

    it 'is not valid without a description' do
      trivia = Trivia.new(description: nil)
      expect(trivia).not_to be_valid
    end

    it 'is not valid without a test letter' do
      trivia = Trivia.new(test_letter: nil)
      expect(trivia).not_to be_valid
    end

    it 'is not valid without a mode' do
      trivia = Trivia.new(mode: nil)
      expect(trivia).not_to be_valid
    end
  end
end
