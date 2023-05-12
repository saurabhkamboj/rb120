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
  attr_accessor :move, :name

  def initialize
    set_name
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

  def choose
    print "Choose between rock, paper or scissor: "
    input = ''

    loop do
      input = gets.chomp.downcase

      break if Move::VALUES.include?(input)
      puts "Error! Please input a valid choice."
    end

    self.move = Move.new(input)
  end
end

class Computer < Player
  def set_name
    self.name = 'Computer'
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class Move
  attr_reader :value

  VALUES = ['rock', 'paper', 'scissor']

  def initialize(value)
    @value = value
  end

  def >(other_move)
    (@value == 'rock' && other_move.value == 'scissor') ||
      (@value == 'scissor' && other_move.value == 'paper') ||
      (@value == 'paper' && other_move.value == 'rock')
  end

  def to_s
    @value.capitalize
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    display_welcome_message
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thank you for playing #{human.name.capitalize}."
  end

  def display_winner
    puts "You chose #{human.move}."
    puts "The computer chose #{computer.move}."

    if human.move > computer.move
      puts "You won!"
    elsif computer.move > human.move
      puts "Computer won!"
    else
      puts "It's a tie."
    end
  end

  def play_again?
    print "Do you want to play again? "
    input = gets.chomp.downcase

    ['n', 'no'].any?(input)
  end

  def play
    loop do
      human.choose
      computer.choose
      display_winner

      break if play_again?
    end

    display_goodbye_message
  end
end

RPSGame.new.play
