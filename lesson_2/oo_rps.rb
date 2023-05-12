=begin
  Rock, Paper, Scissors is a two-player game where each player chooses
  one of three possible moves: rock, paper, or scissors. The chosen moves
  will then be compared to see who wins, according to the following rules:

  - rock beats scissors
  - scissors beats paper
  - paper beats rock

  If the players chose the same move, then it's a tie.

  Nouns: player, move, rule
  Verbs: choose, compare
  
  Organisation for nouns and verbs:
    Player
      Choose
    Move
    Rule

    Compare
=end

class Player
  def initialize(player_type)
    @player_type = player_type
    @move = nil
  end

  def choose
    if human?
      print "Choose between rock, paper or scissors: "

      loop do
        @move = gets.chomp

        break if ['rock', 'paper', 'scissor'].include?(@move)
        puts "Error! Please input a valid choice."
      end
    else
      @move = ['rock', 'paper', 'scissors'].sample
    end
  end

  def human?
    @player_type == :human
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new(:human)
    @computer = Player.new(:computer)
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thank you for playing."
  end

  def play
    display_welcome_message
    human.choose
    computer.choose
    # display_winner
    # display_goodbye_message
  end
end

class Move
  def initialize
    # seems like we need something to keep track
    # of the choice... a move object can be "paper", "rock" or "scissors"
  end
end

class Rule
  def initialize
    # not sure what the "state" of a rule object should be
  end
end

# not sure where "compare" goes yet
def compare(move1, move2)

end

RPSGame.new.play
