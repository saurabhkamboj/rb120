# Description: Tic Tac Toe is a 2-player board game played on a 3x3 grid. Players
# take turns marking a square. The first player to mark 3 squares in a row wins.

# Nounce: board, player, square, grid
# Verbs: play and mark

# Board
# Square
# Player
# - Mark
# - Play

require 'pry'

module Displayable
  def display_welcome_message
    puts "Welcome to TIC TAC TOE"
    puts ""
  end

  def display_board(clear_screen: false)
    clear if clear_screen
    puts "Your marker is #{human.marker}. Computer's marker is #{computer.marker}!"
    puts ""
    board.draw
    puts ""
  end

  def display_result
    if !!board.winning_marker
      if board.winning_marker == TTTgame::HUMAN_MARKER
        puts "You won!"
      else
        puts "Computer won!"
      end
    else
      puts "It's a tie!"
    end
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

  def []=(key, marker)
    @squares[key].marker = marker
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

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @@move_order = [human, computer]
  end

  def play
    display_welcome_message

    loop do
      display_board

      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        display_board(clear_screen: true)
      end
      
      display_board(clear_screen: true)
      display_result

      break unless play_again?
      reset
      display_playagain_message
    end

    display_goodbye_message
  end

  private

  attr_reader :board, :human, :computer

  def current_player_moves
    if humans_turn?
      human_moves
      @@move_order.reverse!
    else
      computer_moves
      @@move_order.reverse!
    end
  end

  def humans_turn?
    @@move_order[0] == human
  end

  def human_moves
    print "Choose a square between #{board.unmarked_square_keys}: "
    square = nil

    loop do
      square = gets.chomp.to_i

      break if board.unmarked_square_keys.include?(square)
      print "Error! Please choose a valid square: "
    end

    board[square] = human.marker
  end

  def computer_moves
    square = board.unmarked_square_keys.sample
    board[square] = computer.marker
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
