require_relative "card"
require_relative "deck"
require_relative "hand"
require "pry"

def print_cards
  @player.cards.each do |card|
    print "#{card.rank}#{card.suit} "
  end
end

def print_dealer_cards
  @dealer.cards.each do |card|
    print "#{card.rank}#{card.suit} "
  end
end

def player_has_blackjack
  puts "You got blackjack! Let's check on the dealer..."
  sleep(0.5)
  if @dealer_score == 21
    puts "Oh no! Dealer has blackjack too! Dealer wins."
  else
    print "Dealer has "
    print_dealer_cards
    puts "(#{@dealer_score} pts). You win! YAYYYYYYYY GOOD JOB!!"
  end
end

def prompt_player
  print_cards
  puts "\nYour current score is #{@score}."
  if @score == 21
    player_has_blackjack
  else
    puts "Would you like to hit or stay? H/S"
  end
end


puts "Welcome to Blackjack!"
sleep(0.5)

play = true

while play do
  deck = Deck.new
  deck.shuffle!

  @player = Hand.new(deck.deal!(2))
  @dealer = Hand.new(deck.deal!(2))

  @score = @player.calculate_hand
  @dealer_score = @dealer.calculate_hand

  @continue = true

  puts "Dealer has #{@dealer.cards[0].rank}#{@dealer.cards[0].suit}"
  print "Your starting hand is: "
  if @score == 21
    print_cards
    puts "You got dealt blackjack!\nYou win! YAYYYYYYYY GOOD JOB!!"
    @continue = false
  else
    prompt_player
    @move = gets.chomp
  end

  while @continue do
    if @move.downcase == 'h'
      @player.cards << deck.deal!(1)[0]
      @score = @player.calculate_hand
      if @score > 21
        print "Your hand is now: "
        print_cards
        puts "\nScore: #{@score}\nBust! You lose."
        @continue = false
      elsif @score < 21
        print "Your hand is now: "
        prompt_player
        @move = gets.chomp
      else
        player_has_blackjack
        @continue = false
      end

    elsif @move.downcase == 's'
      print "Dealer's turn!\nDealer has "
      print_dealer_cards
      puts "\nDealer's starting score is #{@dealer_score}."

      if @dealer_score == 21
        puts "Dealer got blackjack!"
        puts "Dealer wins! You lose!"
        @continue = false
      end

      while @dealer_score < 17
        puts "\nDealer Hits."
        @dealer.cards << deck.deal!(1)[0]
        sleep(0.5)
        puts "#{@dealer.cards.last.rank}#{@dealer.cards.last.suit}"
        @dealer_score = @dealer.calculate_hand
        puts "The dealer now has #{@dealer_score}."
      end

      sleep(1)
      puts "\n"
      if @dealer_score > 21
        puts "Dealer busts. You win! YAYYYYYYYY GOOD JOB!!"
      elsif @dealer_score == @score && @dealer_score != 21
        puts "Cat's Game -- you tied."
      elsif @dealer_score > @score || @dealer_score == 21
        puts "Dealer wins! You lose!"
      else
        puts "Your hand is better than the dealer's. You win! YAYYYYYYYY GOOD JOB!!"
      end

      @continue = false
    else
      while @move.downcase != "h" && @move.downcase != "s"
        puts "I didn't understand that, sorry. Hit or Stay?"
        @move = gets.chomp
      end
    end
  end

  ask = true
  while ask do
    puts "Would you like to play again? Y/N"
    input = gets.chomp
    if input.downcase == 'n'
      play = false
      ask = false
    elsif input.downcase != 'y' && input.downcase != 'n'
      puts "I'm sorry, I didn't understand that. Would you like to play again?"
      input = gets.chomp
    else
      ask = false
    end
  end

end
