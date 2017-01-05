require "spec_helper"

RSpec.describe Hand do
  let(:hand1) { Hand.new([Card.new('10', "♦"), Card.new("J", "♥")]) }

  describe "#initialize" do
    it "contains cards" do
      expect(hand1.cards[0]).to be_a(Card)
    end
  end

  describe "#calculate_values" do
    context "when card is numerical" do
      let(:hand4) { Hand.new([Card.new("9", "♠"), Card.new("8", "♦")]) }
      it "assigns the card a value of its numberical rank" do
        hand4.calculate_values
        expect(hand4.cards[1].value).to eq(8)
      end
    end

    context "when card is an ace" do
      let(:hand5) { Hand.new([Card.new("A", "♠"), Card.new("10", "♦")]) }
      it "assigns the card a value of 11" do
        hand5.calculate_values
        expect(hand5.cards[0].value).to eq(11)
      end
    end

    context "when card is a face card" do
      let(:hand6) { Hand.new([Card.new('10', "♦"), Card.new("K", "♥")]) }
      it "assigns the card a value of 10" do
        hand6.calculate_values
        expect(hand6.cards[1].value).to eq(10)
      end
    end
  end

  describe "#contains_ace?" do
    context "when there is an ace in the hand" do
      let(:hand7) { Hand.new([Card.new("A", "♠"), Card.new("7", "♦")]) }
      it "returns true" do
        expect(hand7.contains_ace?).to eq(true)
      end
    end
    context "when there are no aces in the hand" do
      let(:hand8) { Hand.new([Card.new("10", "♠"), Card.new("7", "♦")]) }
      it "returns false" do
        expect(hand8.contains_ace?).to eq(false)
      end
    end
  end

  describe "#all_aces?" do
    context "when the hand only contains aces" do
      let(:hand2) { Hand.new([Card.new("A", "♠"), Card.new("A", "♦")]) }
      it "returns true" do
        expect(hand2.all_aces?).to eq(true)
      end
    end

    context "when there is something in the hand that is not an ace" do
      let(:hand9) { Hand.new([Card.new('10', "♦"), Card.new("J", "♥")]) }
      it "returns false" do
        expect(hand9.all_aces?).to eq(false)
      end
    end
  end

  describe "#calculate_hand" do
    let(:hand9) { Hand.new([Card.new('10', "♦"), Card.new("J", "♥")]) }
    it "adds the values of the cards" do
      expect(hand9.calculate_hand).to eq(20)
    end
  end

  describe "#account_for_aces" do

    context "when the hand contains at least one ace" do
      context "when score is low" do
        let(:hand10) { Hand.new([Card.new("A", "♠"), Card.new("8", "♦")]) }
        it "counts ace as 11 points" do
          expect(hand10.calculate_hand).to eq(19)
        end
      end

      context "when score is high" do
        let(:hand11) { Hand.new([Card.new("A", "♠"), Card.new('9', "♦"), Card.new("K", "♥")]) }
        it "counts ace as 1 point" do
          expect(hand11.calculate_hand).to eq(20)
        end

        context "when there is more than one ace" do
          let(:hand12) { Hand.new([Card.new("A", "♠"), Card.new("A", "♦"), Card.new("A", "♥"), Card.new("A", "♣")]) }
          it "counts their values appropriately" do
            expect(hand12.calculate_hand).to eq(14)
          end
        end

      end
    end
  end
  
end
