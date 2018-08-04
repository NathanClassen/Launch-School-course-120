module Hand
  def show_hand
    system 'clear'
    puts "Current total: #{hand_score}"
    hand.each do |card|
      sleep 0.5
      puts card
    end
  end

  def hand_score
    score = 0
    hand.each do |card|
      score += card.valuation
    end
    hand.select { |card| card.value == 'A' }.count.times do
      break if score <= 21
      score -= 10
    end
    score
  end
end

class Participant
  attr_accessor :hand

  include Hand

  def initialize
    @hand = Array.new
  end

  def hit?
    puts "Will you (h)it or (s)tay?"
    answer = nil
    loop do
      answer = gets.chomp.downcase
      break if ['h', 's'].include?(answer)
      puts "Please enter 'h' or 's':"
    end
    answer == 'h' ? (return true) : false
  end

  def bust?
    hand_score > 21
  end
end

class Player < Participant
  def initialize
    super
  end
end

class Dealer < Participant
  attr_accessor :deck

  def initialize
    super
    @deck = Deck.new
  end

  def deals(how_many, to_whom)
    how_many.times do
      to_whom.hand << deck.cards.delete(deck.cards.sample)
    end
  end
end

class Card
  attr_accessor :suit, :value
  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def to_s
    puts '+------+'
    puts "|#{suit}    |"
    puts '|      |'
    value.size == 1 ? (puts "|   #{value}  |") : (puts "|   #{value} |")
    puts '|      |'
    puts "|    #{suit}|"
    puts '+------+'
    ''
  end

  def valuation
    if ('2'..'10').include?(value)
      value.to_i
    elsif ['J', 'Q', 'K'].include?(value)
      10
    else
      11
    end
  end
end

class Deck
  attr_accessor :cards
  SUITS =  ['<>', '<3', '<-', '**']
  VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
  def initialize
    @cards = Array.new
    populate_deck
  end

  def populate_deck
    SUITS.each do |suit|
      VALUES.each { |val| cards << Card.new(suit, val) }
    end
  end
end

class Game
  attr_accessor :dealer, :player

  def initialize
    @player = Player.new
    @dealer = Dealer.new
  end

  def reset
    dealer.deck = Deck.new
    player.hand = Array.new
    dealer.hand = Array.new
  end

  def deal_hands
    clear
    dealer.deals(2, player)
    dealer.deals(2, dealer)
  end

  def start
    loop do
      deal_hands
      players_turn
      break if player.bust?
      dealers_turn
      break if dealer.bust?
      display_winner
      break unless play_again?
      reset
    end
    bust_game if player.bust? || dealer.bust?
  end

  def bust_game
    show_busts
    return unless play_again?
    reset
    start
  end

  def play_again?
    puts "Would you like to play again? (y/n): "
    answer = nil
    loop do
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      puts "please enter 'y' or 'n': "
    end
    answer == 'y' ? (return true) : false
  end

  def players_turn
    loop do
      player.show_hand
      break unless player.hit?
      dealer.deals(1, player)
      break if player.bust?
    end
  end

  def dealers_turn
    loop do
      break unless dealer.hand_score < 17
      dealer.deals(1, dealer)
      break if dealer.bust?
    end
  end

  def game_totals_message
    clear
    puts "You had #{player.hand_score} points"
    puts ''
    sleep 0.5
    print "The dealer had #{dealer.hand_score} points"
    6.times { print '.'; sleep 0.1 }
    sleep(1)
  end

  def display_winner
    clear
    game_totals_message
    if player.hand_score > dealer.hand_score
      puts "You Won the Game!"
    elsif player.hand_score < dealer.hand_score
      puts "The Dealer Won the Game!"
    else
      puts "It's a tie."
    end
    sleep 2
    clear
  end

  def show_busts
    if player.bust?
      player_busted
    elsif dealer.bust?
      dealer_busted
    end
  end

  def player_busted
    clear
    player.show_hand
    puts "....you busted"
    sleep(1)
    puts 'The dealer won.'
  end

  def dealer_busted
    clear
    player.show_hand
    puts "...the dealer busted"
    sleep(1)
    puts 'You Won!'
  end

  def clear
    system 'clear'
  end
end

Game.new.start
