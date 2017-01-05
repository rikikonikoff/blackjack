require "spec_helper"

RSpec.describe Deck do
    let(:deck) { Deck.new }

    describe "#initialize" do
      it "populates @cards with card objects" do
        expect(deck.cards.first).to be_a(Card)
      end
    end

    describe "#build_deck" do
      it "builds a deck of 52 cards" do
        expect(deck.cards.size).to eq (52)
      end

      it "creates unique cards" do
        expect(deck.cards.uniq.size).to eq (52)
      end
    end

    describe "#shuffle!" do
      before(:each) do
        srand 10
      end

      it "randomizes the order of the deck" do
        first_card = deck.cards[0]
        deck.shuffle!
        expect(deck.cards[0]).to_not eq(first_card)
      end
    end

    describe "#deal!" do
      it "removes a card" do
        deck.deal!(1)
        expect(deck.cards.size).to eq(51)
      end
      it "removes multiple cards" do
        start_size = deck.cards.size
        finish_size = start_size - 2
        deck.deal!(2)
        expect(deck.cards.size).to eq finish_size
      end

      it "returns the removed card" do
        dealt_card = deck.deal!(1)[0]
        expect(dealt_card).to be_a(Card)
      end
    end
  end
