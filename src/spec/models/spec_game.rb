require_relative '../../models/init'

describe Game do
  context "validations" do

    it "is valid with valid attributes" do
      game = Game.new(number: 1, name:"Nombre de Game", genre:"Genero")
      expect(game).to be_valid
    end

    it "is not valid without a number" do
      game = Game.new(number: nil)
      expect(game).not_to be_valid
    end

    it "is not valid without a name" do
      game = Game.new(name: nil)
      expect(game).not_to be_valid
    end

    it "is not valid without a genre" do
      game = Game.new(genre: nil)
      expect(game).not_to be_valid
    end
end