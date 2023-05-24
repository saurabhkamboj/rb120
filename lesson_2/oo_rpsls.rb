VALID_CHOICES = %w(rock paper scissors lizard spock)
OUTCOMES = {
  rock: %w(scissors lizard),
  paper: %w(rock spock),
  scissors: %w(paper lizard),
  lizard: %w(spock paper),
  spock: %w(rock scissors)
}

module Storable
  MOVES_HISTORY = {}

  class Game
    @@game = 0

    def initialize
      @@game += 1
      @@match = 0
      MOVES_HISTORY[@@game] = {}
    end

    def self.store_move(value)
      MOVES_HISTORY[@@game][@@match] << value
    end
  end

  class Match < Game
    def initialize
      @@match += 1
      MOVES_HISTORY[@@game][@@match] = []
    end
  end
end

module Movable
  def ai_move(name)
    case name
    when 'Computron'
      VALID_CHOICES.sample
    when 'R2D2'
      'rock'
    when 'Hal'
      [['rock'] * 2, ['paper'] * 5, 'scissors', 'lizard', 'spock'].sample
    end
  end

  def computer_moves
    MOVES_HISTORY.map do |_, matches|
      matches.map do |_, moves|
        moves[1]
      end
    end.flatten
  end
end

module Displayable
  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_moves
    puts "\nYou chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}}."
  end

  # rubocop:disable Metrics/AbcSize
  def display_winner
    if human.move > computer.move
      puts "You won!"
      human.score += 1
    elsif computer.move > human.move
      puts "#{computer.name} won!"
      computer.score += 1
    else
      puts "It's a tie."
      Score.games_tied += 1
    end
  end
  # rubocop:enable Metrics/AbcSize

  def display_score
    puts "\nScore
    #{human.name} - #{human.score}
    #{computer.name} - #{computer.score}
    Ties - #{Score.games_tied}"
  end

  def display_history
    Storable::MOVES_HISTORY.each do |game, matches|
      puts "Game #{game}"
      matches.each do |match, moves|
        puts "Match #{match} => #{moves}"
      end
    end
  end

  def display_goodbye_message
    puts "\nThank you for playing #{human.name}."
  end
end

class Player
  attr_accessor :move
  attr_writer :name

  def initialize
    set_name
    @score = Score.new
  end

  def name
    @name.capitalize
  end

  def score=(value)
    @score.value = value
  end

  def score
    @score.value
  end
end

class Human < Player
  def set_name
    print "What should we call you? "
    input = ''

    loop do
      input = gets.chomp

      break unless input.empty?
      print "Error! You must enter a value: "
    end

    self.name = input
  end

  def move!
    print "Choose between rock, paper, scissors, lizard or spock: "
    input = ''

    loop do
      input = gets.chomp.downcase

      break if VALID_CHOICES.include?(input)
      print "Error! Please enter a valid choice: "
    end

    self.move = Move.new(input)
  end
end

class Computer < Player
  include Movable
  include Displayable

  def set_name
    self.name = %w(Computron R2D2 Hal).sample
  end

  def move!
    self.move = Move.new(ai_move(name))
  end
end

class Move
  attr_reader :value

  def initialize(value)
    @value = value
    Storable::Game.store_move(@value)
  end

  def >(other_move)
    OUTCOMES[value.to_sym].include?(other_move.value)
  end

  def to_s
    @value.capitalize
  end
end

class Score
  attr_accessor :value

  WINNING_SCORE = 2

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

class RPSGame
  attr_accessor :human, :computer

  def initialize
    display_welcome_message
    @human = Human.new
    @computer = Computer.new
  end

  def play
    loop do
      Storable::Game.new
      main_game

      human.score = 0
      computer.score = 0

      break if play_again?
    end

    display_history
    display_goodbye_message
  end

  protected

  def main_game
    loop do
      Storable::Match.new
      human.move!
      computer.move!
      display_winner
      display_score
      break if game_won?

      sleep 5
      system('clear') || system('cls')
    end
  end

  def game_won?
    if human.score == Score::WINNING_SCORE
      !(puts "\nYay...you won the game!")
    elsif computer.score == Score::WINNING_SCORE
      !(puts "\n#{computer.name} won the game!")
    else
      puts "\nNext round..."
    end
  end

  def play_again?
    print "Do you want to play again? "
    input = gets.chomp.downcase

    ['n', 'no'].any?(input)
  end
end

RPSGame.new.play
