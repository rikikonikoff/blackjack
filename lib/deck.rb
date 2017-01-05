require_relative 'card'

class Deck
  SUITS = ['♦', '♣', '♠', '♥']
  RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
  attr_accessor :cards

  def initialize
    @cards = build_deck
  end

  def build_deck
    cards = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        card = Card.new(rank, suit)
        cards << card
      end
    end
    cards
  end

  def shuffle!
    @cards.shuffle!
  end

  def deal!(number)
    @cards.pop(number)
  end


end
