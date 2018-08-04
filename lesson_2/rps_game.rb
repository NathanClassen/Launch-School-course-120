class Move
  attr_reader :value
  VALUES = ['rock', 'paper', 'scissors']

  def initialize(value)
    @value = value
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def scissors?
    @value == 'scissors'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end
end

## Player Classes #####################################

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end
end

class Human < Player
  def set_name
    puts "What is your name?"
    self.name = gets.chomp.capitalize
    system 'clear'
  end

  def choose
    choice = nil
    loop do
      puts "Please choose 'rock', 'paper', or 'scissors':"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice.."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = [
      'Charles', 'R2D2', 'C3PO', +
      'Yo Mama', 'William', 'Maximus'
    ].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

## RPSGame Engine #####################################

class RPSGame
  attr_accessor :human, :computer, :leader
  
  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_mssg
    puts "Welcome to Rock, Paper, Scissors #{human.name}!"
  end

  def display_goodbye_mssg
    puts "Thanks for playing, See you next time!"
  end

  def display_winner
    puts "#{human.name} chose #{human.move.value}"
    sleep 1
    system 'clear'
    3.times { print '.'; sleep 0.5 }
    system 'clear'
    print "#{computer.name} chose #{computer.move.value}"
    3.times { print '.'; sleep 0.5 }
    system 'clear'

    if human.move > computer.move
      human.score += 1
      puts "You won!"
    elsif computer.move > human.move
      computer.score += 1
      puts "#{computer.name} won."
    else
      puts "It's a tie!"
    end
  end

  def display_scores
    puts "#{human.name} => #{human.score}"
    puts "#{computer.name} => #{computer.score}"
    puts ''
    puts 'First to 3 wins.'
  end


  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      system 'clear'
      break if ['y', 'n'].include? answer
      puts "Sorry, must answer y or n.."
    end
    return true unless answer == 'n'
  end

  def display_victor p1, p2
    if p1.score > p2.score
      puts "You defeated #{computer.name}!!!!"
    else
      puts "#{computer.name} defeated you....."
    end
  end

  def play
    display_welcome_mssg
    sleep 2
    system 'clear'
    loop do
      loop do
        human.choose
        computer.choose
        display_winner
        sleep 1.3
        system 'clear'
        sleep 1
        display_scores
        sleep 1.5
        system 'clear'
        break if human.score >= 3 || computer.score >= 3
      end
      display_victor human, computer
      sleep 1.7
      break unless play_again?
      system 'clear'
    end
    display_goodbye_mssg
    sleep 2.5
    system 'clear'
  end
end

RPSGame.new.play
