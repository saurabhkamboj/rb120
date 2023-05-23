# Description: Tic Tac Toe is a 2-player board game played on a 3x3 grid. Players
# take turns marking a square. The first player to mark 3 squares in a row wins.

# Nounce: board, player, square, grid
# Verbs: play and mark

# Board
# Square
# Player
#   - Mark
#   - Play

module Displayable
  def display_welcome_message
    puts "TIC TAC TOE"
    puts ""
  end

  def display_board(board)
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

  def display_result
  end

  def display_goodbye_message
    puts "Thank you for playing!"
  end
end

class Board
  def initialize
    @squares = (1..9).zip([Square.new(' ')] * 9).to_h
  end

  def get_square_at(key)
    @squares[key]
  end
end

class Square
  def initialize(marker)
    @marker = marker
  end

  def to_s
    @marker
  end
end

class Player
  def initialize
    # Keep track of player's symbol
  end

  def mark
  end
end

class TTTgame
  include Displayable

  attr_reader :board

  def initialize
    @board = Board.new
  end

  def play
    display_welcome_message

    loop do
      display_board(board)
      break
      first_player_moves
      break if someone_won? || board_full?

      second_player_moves
      break if someone_won? || board_full?
    end

    display_result
    display_goodbye_message
  end
end

game = TTTgame.new
game.play
