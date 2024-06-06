require_relative '../../models/init'

describe AccountTrivia do
  context "validations" do

    it "is valid with valid attributes" do
      account_trivia = AccountTrivia.new(trivia_completed: false, correct_questions: 3, account_id: 4, trivia_id: 2)
      expect(account_trivia).to be_valid
    end

    it "is not valid without a complete value" do
      account_trivia = AccountTrivia.new(trivia_completed: nil)
      expect(account_trivia).not_to be_valid
    end

    it "is not valid without a correct answers" do
      account_trivia = AccountTrivia.new(correct_questions: nil)
      expect(account_trivia).not_to be_valid
    end
end