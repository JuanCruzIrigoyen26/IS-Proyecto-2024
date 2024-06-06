require_relative '../../models/init'

describe CreateAccountGame do
  context "validations" do

    it "is valid with valid attributes" do
      account_game = CreateAccountGame.new(account_knowledge: "basic", account_id: 2, trivia_id: 1)
      expect(account_game).to be_valid
    end

    it "is not valid without a knowledge value" do
      account_game = CreateAccountGame.new(account_knowledge: nil)
      expect(account_game).not_to be_valid
    end
end