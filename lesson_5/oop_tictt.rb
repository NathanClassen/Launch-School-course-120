class Board
  INITIAL_MARK = " "
  WINNING_LINES = [[1, 2, 3], [4, 5, 6],
                   [7, 8, 9], [1, 4, 7],
                   [2, 5, 8], [3, 6, 9],
                   [1, 5, 9], [3, 5, 7]]
  attr_reader :squares

  def initialize
    @squares = {}
    set_up_board
  end

  def generate
    puts ""
    puts "     |     |     "
    puts "  #{squares[1]}  |  #{squares[2]}  |  #{squares[3]}  "
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{squares[4]}  |  #{squares[5]}  |  #{squares[6]}  "
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{squares[7]}  |  #{squares[8]}  |  #{squares[9]}  "
    puts "     |     |     "
    puts ""
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key] == Board::INITIAL_MARK }
  end

  def get_square(at)
    @squares[at]
  end

  def full?
    !squares.value?(" ")
  end

  def set_up_board
    (1..9).each { |s| @squares[s] = INITIAL_MARK }
  end
end

class Square
  def initialize(marker)
    @mark = marker
  end

  def to_s
    @mark
  end
end

class Player
  attr_accessor :score, :name, :signature

  def initialize(mark, name)
    @signature = mark
    @score = 0
    @name = name
  end

  def mark(board, square)
    board.squares[square] = @signature
  end
end

class TTTGame
  attr_reader :board, :human, :computer
  attr_accessor :current_player

  def initialize
    @board = Board.new
    @human = Player.new(pick_marker, pick_name)
    @computer = Player.new(determine_computer_marker, names.sample)
    @current_player = x_player
  end

  def pick_marker
    clear
    marker = nil
    loop do
      puts "Would you like to be X's or O's?"
      marker = gets.chomp.downcase
      break if ['x', 'o'].include?(marker)
      puts "Invalid input..."
    end
    return "O" unless marker == 'x'
    "X"
  end

  def pick_name
    clear
    n = nil
    puts "What is your name?(no spaces)"
    loop do
      n = gets.chomp.capitalize
      break unless n.empty? || n.include?(' ')
      print "Please enter a valid name: "
    end
    n
  end

  def determine_computer_marker
    return "X" unless human.signature == "X"
    "O"
  end

  def names
    ['Greg', 'Beatrice', 'Charles', 'David', 'Mickey', 'Linus', 'Elizabeth'] +
      ['Regina', 'Matthew', 'Yolanda', 'Rebeckah', 'Sarah', 'Madison', 'Eddy'] +
      ['Roberto', 'Richard', 'Samantha', 'John', 'Susanna', 'Xavier', 'James'] +
      ['Dorothy', 'Marie', 'Henrey', 'Alexandria', 'Lance', 'Stephen', 'Rudy'] +
      ['Charolette', 'Lee', 'Ann']
  end

  def play
    display_welcome_message
    loop do
      loop do
        display_board
        loop do
          current_player_moves
          clear_screen_and_display_board
          break if game_end_conditions?
        end
        update_scores
        break if game_over?
        display_results
        sleep 1.3
        reset_game
      end
      display_game_winner
      break unless play_again?
      reset_game
    end
    display_goodbye_message
  end

  private

  def game_end_conditions?
    someone_won? || board.full?
  end

  def display_game_winner
    puts "#{game_winner} won the game!!!!"
  end

  def game_winner
    if human.score > computer.score
      human.name
    else
      computer.name
    end
  end

  def someone_won?
    !!winning_marker
  end

  def human_marker_count(squares)
    squares.count(human.signature)
  end

  def computer_marker_count(squares)
    squares.count(computer.signature)
  end

  def winning_marker
    Board::WINNING_LINES.each do |line|
      if human_marker_count(board.squares.values_at(*line)) == 3
        return human.signature
      elsif computer_marker_count(board.squares.values_at(*line)) == 3
        return computer.signature
      end
    end
    nil
  end

  def display_scores
    puts "First to 5 wins the game"
    puts "#{human.name}'s Score: #{human.score}"
    puts "#{computer.name}'s Score: #{computer.score}"
  end

  def game_over?
    human.score >= 5 || computer.score >= 5
  end

  def update_scores
    if winning_marker == human.signature
      human.score += 1
    elsif winning_marker == computer.signature
      computer.score += 1
    end
  end

  def current_player_moves
    if current_player == human.signature
      human_moves
      self.current_player = computer.signature
    else
      computer_moves
      self.current_player = human.signature
    end
  end

  def display_welcome_message
    puts "Hello! And welcome to Tic-Tac-Toe!!"
    puts ""
  end

  def display_goodbye_message
    clear
    puts ''
    puts "Thanks for playing Tic-Tac-Toe!!"
    puts ''
    puts ''
  end

  def display_board
    puts "You are '#{human.signature}' and #{computer.name}" \
      " is '#{computer.signature}'"
    display_scores
    puts ""
    board.generate
    puts ""
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_moves
    chosen_square = 0
    print "Choose a square (#{board.unmarked_keys.join(' ')}):"
    loop do
      chosen_square = gets.chomp.to_i
      break if board.unmarked_keys.include?(chosen_square)
      print "Invalid square. Choose another:"
    end
    human.mark(board, chosen_square)
  end

  def computer_moves
    if strong_ai_move
      space = strong_ai_move
      board.squares[space] = computer.signature
    elsif danger
      space = danger
      board.squares[space] = computer.signature
    elsif weak_ai_move
      space = weak_ai_move
      board.squares[space] = computer.signature
    elsif board.unmarked_keys.include?(5)
      board.squares[5] = computer.signature
    else
      space = board.unmarked_keys.sample
      board.squares[space] = computer.signature
    end
  end

  def strong_ai_move
    Board::WINNING_LINES.each do |line|
      if board.squares.values_at(*line).count(computer.signature) == 2
        line.each do |space|
          if board.squares[space] == ' '
            return space
          end
        end
      end
    end
    false
  end

  def danger
    Board::WINNING_LINES.each do |line|
      if board.squares.values_at(*line).count(human.signature) == 2
        line.each do |space|
          if board.squares[space] == ' '
            return space
          end
        end
      end
    end
    false
  end

  def weak_ai_move
    Board::WINNING_LINES.each do |line|
      if board.squares.values_at(*line).count(computer.signature) == 1
        potential_moves = []
        line.each do |num|
          if board.squares[num] == ' '
            potential_moves << num
          end
        end
        return potential_moves.sample
      end
    end
    false
  end

  def display_results
    case winning_marker
    when human.signature then puts "You won!!"
    when computer.signature then puts "#{computer.name} won."
    else puts "It's a Cat's game........"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y / n)"
      answer = gets.chomp.downcase
      break if %(y n).include? answer
      puts "Enter either 'y' or 'n'"
    end
    answer == 'y'
  end

  def clear
    system 'clear'
  end

  def reset
    clear
    board.set_up_board
  end

  def x_player
    if human.signature == 'X'
      human.signature
    else
      computer.signature
    end
  end

  def reset_game
    reset
    self.current_player = x_player
  end

  def display_play_again_message
    puts "Let's play agian!"
    puts ""
  end
end

game = TTTGame.new
game.play
