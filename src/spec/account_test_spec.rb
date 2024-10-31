# frozen_string_literal: true

require File.expand_path('../models/init', __dir__)

describe AccountTest do
  context 'validations' do
    it 'is valid with valid attributes' do
      account_test = AccountTest.new(test_completed: false, account_id: 5, test_id: 3)
      expect(account_test).to be_valid
    end

    it 'is not valid without a complete value' do
      account_test = AccountTest.new(test_completed: nil)
      expect(account_test).not_to be_valid
    end
  end
end
