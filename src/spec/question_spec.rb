# frozen_string_literal: true

require File.expand_path('../models/init', __dir__)

describe Question do
  context 'validations' do
    it 'is valid with valid attributes' do
      question = Question.new(number: 1, description: 'Esto es una question valida', test_letter: 'A')
      expect(question).to be_valid
    end

    it 'is not valid without a number' do
      question = Question.new(number: nil)
      expect(question).not_to be_valid
    end

    it 'is not valid without a description' do
      question = Question.new(description: nil)
      expect(question).not_to be_valid
    end

    it 'is not valid without a test letter' do
      question = Question.new(test_letter: nil)
      expect(question).not_to be_valid
    end
  end
end
