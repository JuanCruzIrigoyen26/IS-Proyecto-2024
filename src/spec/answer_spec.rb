require File.expand_path('../../models/init', __FILE__)

describe Answer do
  context "validations" do

    it "is valid with valid attributes" do
      answer = Answer.new(number: 1, description:"This is an answer", question_number: 1, test_letter: "A")
      expect(answer).to be_valid
    end

    it "is not valid without a number" do
      answer = Answer.new(number: nil)
      expect(answer).not_to be_valid
    end

    it "is not valid without a description" do
      answer = Answer.new(description: nil)
      expect(answer).not_to be_valid
    end

    it "is not valid without a question number" do
      answer = Answer.new(question_number: nil)
      expect(answer).not_to be_valid
    end

    it "is not valid without a test letter" do
        answer = Answer.new(test_letter: nil)
        expect(answer).not_to be_valid
    end
  end
end