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

  def initialize(player_type)
    @player_type = player_type
    @move = nil
    set_name
  end

  def set_name
    if human?
      print "What should we call you? "

      loop do
        self.name = gets.chomp

        break unless self.name.empty?
        print "Error! You must enter a value: "
      end
    else
      self.name = 'Computer'
    end
  end

  def choose
    if human?
      print "Choose between rock, paper or scissor: "

      loop do
        self.move = gets.chomp.downcase

        break if ['rock', 'paper', 'scissor'].include?(@move)
        puts "Error! Please input a valid choice."
      end
    else
      self.move = ['rock', 'paper', 'scissor'].sample
    end
  end

  def human?
    @player_type == :human
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    display_welcome_message
    @human = Player.new(:human)
    @computer = Player.new(:computer)
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thank you for playing #{human.name.capitalize}."
  end

  def display_winner
    puts "You chose #{human.move.capitalize}."
    puts "The computer chose #{computer.move.capitalize}."
    puts result(human.move, computer.move)
  end

  def win?(move_1, move_2)
    (move_1 == 'rock' && move_2 == 'scissor') ||
      (move_1 == 'scissor' && move_2 == 'paper') ||
      (move_1 == 'paper' && move_2 == 'rock')
  end

  def result(human_move, computer_move)
    if win?(human_move, computer_move)
      "You won!"
    elsif win?(computer_move, human_move)
      "Computer won!"
    else
      "It's a tie."
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
