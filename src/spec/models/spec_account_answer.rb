require_relative '../../models/init'

describe AccountAnswer do
  context "validations" do

    it "is valid with valid attributes" do
      account_answer = AccountAnswer.new(account_id: 6, question_id: 3, answer_id: 4)
      expect(account_answer).to be_valid
    end
end