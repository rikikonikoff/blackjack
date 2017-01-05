require 'pry'

class Card
  attr_reader :rank, :suit
  attr_accessor :value

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = 0
  end

  def ace?
    if rank == 'A'
      true
    else
      false
    end
  end

  def face_card?
    if rank == "J" || rank == "Q" || rank == "K"
      true
    else
      false
    end
  end

end
