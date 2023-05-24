# Description: Tic Tac Toe is a 2-player board game played on a 3x3 grid. Players
# take turns marking a square. The first player to mark 3 squares in a row wins.

# Nounce: board, player, square, grid
# Verbs: play and mark

# Board
# Square
# Player
#   - Mark
#   - Play

require 'pry'

module Displayable
  def display_welcome_message
    puts "Welcome to TIC TAC TOE"
    puts ""
  end

  def display_board(clear_screen)
    clear if clear_screen
    puts "Your marker is #{human.marker}. Computer's marker is #{computer.marker}!"
    puts ""
    puts "     |     |"
    puts "  #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  |  #{board.get_square_at(3)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  |  #{board.get_square_at(6)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  |  #{board.get_square_at(9)}"
    puts "     |     |"
    puts ""
  end

  def display_result(board)
    if board.someone_won?
      puts "#{board.detect_winner} won!"
    else
      "It's a tie!"
    end
  end

  def display_goodbye_message
    puts "Thank you for playing TIC TAC TOE!"
  end

  def clear
    system('clear') || system('cls')
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

  def get_square_at(key)
    @squares[key]
  end

  def set_square_at(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_square_keys
    squares.select { |_, square| square.unmarked? }.keys
  end

  def someone_won?
    !!detect_winner
  end

  def detect_winner
    WINNING_LINES.each do |line|
      if line.all? { |key| squares[key].marker == TTTgame::HUMAN_MARKER }
        return 'You'
      elsif line.all? { |key| squares[key].marker == TTTgame::COMPUTER_MARKER }
        return 'Computer'
      end
    end

    nil
  end

  def full?
    unmarked_square_keys.empty?
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
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
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTgame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'

  include Displayable

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end

  def human_moves
    print "Choose a square between #{board.unmarked_square_keys}: "
    square = nil

    loop do
      square = gets.chomp.to_i

      break if board.unmarked_square_keys.include?(square)
      print "Error! Please choose a valid square: "
    end

    board.set_square_at(square, human.marker)
  end

  def computer_moves
    board.set_square_at(board.unmarked_square_keys.sample, computer.marker)
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

  def play
    display_welcome_message

    loop do
      display_board(false)

      loop do
        human_moves
        break if board.someone_won? || board.full?

        computer_moves
        break if board.someone_won? || board.full?
        display_board(true)
      end
      
      display_board(true)
      display_result(board)

      break unless play_again?
      board.reset
      system('clear') || system('cls')
      puts "Let's play again!"
      puts ""
    end

    display_goodbye_message
  end
end

game = TTTgame.new
game.play
