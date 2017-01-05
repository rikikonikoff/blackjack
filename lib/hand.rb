require_relative 'card'
require_relative 'deck'


class Hand
  attr_accessor :cards, :score

  def initialize(cards)
    @cards = cards
  end

  def calculate_values
    @cards.each do |card|
      if card.face_card?
        card.value = 10
      elsif card.ace?
        card.value = 11
      else
        card.value = card.rank.to_i
      end
    end
  end

  def contains_ace?
    contains_ace = false
    @aces = 0
    @cards.each do |card|
      if card.ace?
        @aces += 1
        contains_ace = true
      end
    end
    contains_ace
  end

  def all_aces?
    all_aces = false
    if contains_ace?
      all_aces = true
      @cards.each do |card|
        if card.ace? == false
          all_aces = false
        end
      end
    end
    all_aces
  end

  def calculate_hand
    calculate_values
    @score = 0
    @cards.each do |card|
      @score += card.value
    end
    account_for_aces
    @score
  end

  def account_for_aces
    if @score > 21 && contains_ace?
      if all_aces?
        @score -= 10 * (@aces - 1)
      else
        @score -= 10 * @aces
      end
    end
  end

end
