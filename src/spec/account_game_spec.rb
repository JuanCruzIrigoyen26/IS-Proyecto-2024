require File.expand_path('../../models/init', __FILE__)


describe AccountGame do
  context "validations" do

    it "is valid with valid attributes" do
      account_game = AccountGame.new(account_knowledge: "basic", account_id: 2, game_id: 1)
      expect(account_game).to be_valid
    end

    it "is not valid without a knowledge value" do
      account_game = AccountGame.new(account_knowledge: nil)
      expect(account_game).not_to be_valid
    end
  end
end