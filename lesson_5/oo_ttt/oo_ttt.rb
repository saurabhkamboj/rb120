require 'pry'

module Displayable
  def display_welcome_message
    puts "Welcome to TIC TAC TOE"
    puts ""
  end

  def display_board
    puts "Your marker is #{human.marker}. " \
      "Computer's marker is #{computer.marker}!"
    puts ""
    board.draw
    puts ""
  end

  def clear_and_display_board
    clear
    display_board
  end

  def display_result
    if board.winning_marker == human.marker
      puts "You won!"
      human.score += 1
    elsif board.winning_marker == computer.marker
      puts "Computer won!"
      computer.score += 1
    else
      puts "It's a tie!"
      Score.games_tied += 1
    end
  end

  def display_score
    puts ""
    puts "Your score - #{human.score}\n" \
    "Computer's score - #{computer.score}\n" \
    "Ties - #{Score.games_tied}"
    puts ""
  end

  def display_goodbye_message
    puts "Thank you for playing TIC TAC TOE!"
  end

  def display_playagain_message
    puts "Let's play again!"
    puts ""
  end

  def clear
    system('clear') || system('cls')
  end

  def joinor(squares, delimiter=',', last_delimiter='or')
    case squares.size
    when 0 then ''
    when 1 then squares.first.to_s
    when 2 then squares.join(" #{last_delimiter} ")
    else
      squares[-1] = "#{last_delimiter} #{squares.last}"
      squares.join("#{delimiter} ")
    end
  end
end

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  attr_reader :squares

  def initialize
    @squares = {}
    reset
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{squares[1]}  |  #{squares[2]}  |  #{squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{squares[4]}  |  #{squares[5]}  |  #{squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{squares[7]}  |  #{squares[8]}  |  #{squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def [](key)
    @squares[key].marker
  end

  def unmarked_square_keys
    squares.select { |_, square| square.unmarked? }.keys
  end

  def winning_marker
    WINNING_LINES.each do |line|
      values = squares.values_at(*line)
      if all_markers_are_same?(values)
        return values.first.marker
      end
    end

    nil
  end

  def someone_won?
    !!winning_marker
  end

  def full?
    unmarked_square_keys.empty?
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  private

  def all_markers_are_same?(values)
    markers = values.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.all?(markers[1])
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end

  def ==(value)
    marker == value
  end
end

class Player
  attr_accessor :marker

  def initialize
    @marker = nil
    @score = Score.new
  end

  def score
    @score.value
  end

  def score=(value)
    @score.value = value
  end
end

class Score
  attr_accessor :value

  WINNING_SCORE = 5

  @@games_tied = 0

  def initialize
    @value = 0
  end

  def self.games_tied=(value)
    @@games_tied = value
  end

  def self.games_tied
    @@games_tied
  end
end

class TTTgame
  include Displayable

  def initialize
    @board = Board.new
    @human = Player.new
    @computer = Player.new
    @@move_order = [human, computer]
  end

  def play
    display_welcome_message
    choose_marker

    loop do
      main_game

      break unless play_again?
      human.score = 0
      computer.score = 0
      display_playagain_message
    end

    display_goodbye_message
  end

  private

  attr_reader :board, :human, :computer

  def choose_marker
    print "Choose a marker (X/O): "
    answer = ''

    loop do
      answer = gets.chomp.downcase

      break if ['x', 'o'].any?(answer)
      print "Error! Please choose a valid marker: "
    end

    human.marker = answer.upcase
    computer.marker = answer == 'x' ? 'O' : 'X'
  end

  def main_game
    loop do
      clear_and_display_board
      player_move
      clear_and_display_board
      display_result
      display_score

      break if game_won?
      sleep 5
      reset
    end
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_and_display_board
    end
  end

  def current_player_moves
    if humans_turn?
      human_moves
    else
      computer_moves
    end

    @@move_order.reverse!
  end

  def humans_turn?
    @@move_order[0] == human
  end

  def human_moves
    print "Remaining positions [#{joinor(board.unmarked_square_keys)}]: "
    square = nil

    loop do
      square = gets.chomp.to_i

      break if board.unmarked_square_keys.include?(square)
      print "Error! Please choose a valid square: "
    end

    board[square] = human.marker
  end

  def computer_ai(board, marker)
    Board::WINNING_LINES.each do |line|
      if board.squares.values_at(*line).count(marker) == 2 &&
         board.squares.values_at(*line).count(Square::INITIAL_MARKER) == 1
        return board.squares.select do |key, value|
          line.include?(key) && value == Square::INITIAL_MARKER
        end.keys[0]
      end
    end
    nil
  end

  def computer_ai_moves(board, computer_marker, human_marker)
    if !!computer_ai(board, computer_marker) # winning move
      computer_ai(board, computer_marker)
    elsif !!computer_ai(board, human_marker) # defensive move
      computer_ai(board, human_marker)
    elsif board[5] == Square::INITIAL_MARKER
      5
    else
      board.unmarked_square_keys.sample
    end
  end

  def computer_moves
    square = computer_ai_moves(board, computer.marker, human.marker)
    board[square] = computer.marker
  end

  def game_won?
    if human.score == Score::WINNING_SCORE
      !(puts "Yay...you won the game!")
    elsif computer.score == Score::WINNING_SCORE
      !(puts "Computer won the game")
    else
      puts "Next round..."
    end
  end

  def play_again?
    print "Do you want to play again (Yes/No)? "
    answer = nil

    loop do
      answer = gets.chomp.downcase

      break if ['yes', 'no'].any?(answer)
      print "Error! Answer must be yes or no: "
    end

    answer == 'yes'
  end

  def reset
    board.reset
    @@move_order = [human, computer]
    clear
  end
end

game = TTTgame.new
game.play
