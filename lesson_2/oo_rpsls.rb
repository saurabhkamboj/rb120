=begin
  Keeping score
    Right now, the game doesn't have very much dramatic flair. It'll be more interesting if we were playing up to, say, 10 points. Whoever reaches 10 points first wins. Can you build this functionality? We have a new noun -- a score. Is that a new class, or a state of an existing class? You can explore both options and see which one works better.
=end

VALID_MOVES = ['rock', 'paper', 'scissor']
WINNING_SCORE = 2

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
    print "Choose between rock, paper or scissor: "
    input = ''

    loop do
      input = gets.chomp.downcase

      break if VALID_MOVES.include?(input)
      puts "Error! Please input a valid choice."
    end

    self.move = Move.new(input)
  end
end

class Computer < Player
  def set_name
    self.name = 'Computer'
  end

  def move!
    self.move = Move.new(VALID_MOVES.sample)
  end
end

class Move
  attr_reader :value

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

class Score
  attr_accessor :value

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

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_winner
    puts "\nYou chose #{human.move}."
    puts "The computer chose #{computer.move}."

    if human.move > computer.move
      puts "You won!"
      human.score += 1
    elsif computer.move > human.move
      puts "Computer won!"
      computer.score += 1
    else
      puts "It's a tie."
      Score.games_tied += 1
    end
  end

  def display_score
    puts "\nScore
    #{human.name} - #{human.score}
    Computer - #{computer.score}
    Ties - #{Score.games_tied}"
  end

  def game_won?
    if human.score == WINNING_SCORE
      !(puts "\nYay...you won the game!")
    elsif computer.score == WINNING_SCORE
      !(puts "\nThe computer won the game!")
    else
      puts "\nNext round..."
    end
  end

  def play_again?
    print "Do you want to play again? "
    input = gets.chomp.downcase

    ['n', 'no'].any?(input)
  end

  def display_goodbye_message
    puts "\nThank you for playing #{human.name}."
  end

  def play
    loop do
      loop do
        human.move!
        computer.move!
        display_winner
        display_score
        break if game_won?
        
        sleep 6
        system('clear') || system('cls')
      end

      human.score = 0
      computer.score = 0
      
      break if play_again?
    end

    display_goodbye_message
  end
end

RPSGame.new.play
