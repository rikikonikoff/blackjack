require "spec_helper"

RSpec.describe Card do
  let(:card1) {Card.new('9', '♥')}
  let(:card2) {Card.new('A', '♦')}
  let(:card3) {Card.new('J', '♥')}

  describe "#initialize" do
    it "has a rank" do
      expect(card1.rank).to eq('9')
    end

    it "has a suit" do
      expect(card1.suit).to eq('♥')
    end
  end

  describe "#ace?" do
    describe "when card is an ace" do
      it "returns true" do
        expect(card2.ace?).to eq(true)
      end
    end

    describe "when card is not an ace" do
      it "returns false" do
        expect(card1.ace?).to eq(false)
      end
    end
  end

  describe "#face_card?" do
    describe "when card is a face card" do
      it "returns true" do
        expect(card3.face_card?).to eq(true)
      end
    end

    describe "when card is numerical" do
      it "returns false" do
        expect(card1.face_card?).to eq(false)
      end
    end

    describe "when card is an ace" do
      it "returns false for an ace" do
        expect(card2.face_card?).to eq(false)
      end
    end
  end

end
