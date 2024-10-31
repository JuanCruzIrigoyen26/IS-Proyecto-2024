# frozen_string_literal: true

require File.expand_path('../models/init', __dir__)

describe AccountAnswer do
  context 'validations' do
    it 'is valid with valid attributes' do
      account_answer = AccountAnswer.new(account_id: 6, question_id: 3, answer_id: 4)
      expect(account_answer).to be_valid
    end
  end
end
