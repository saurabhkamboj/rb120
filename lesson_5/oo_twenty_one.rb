def green(text); "\e[32m#{text}\e[0m"; end
def red(text); "\e[31m#{text}\e[0m"; end
def yellow(text); "\e[1;33m#{text}\e[0m"; end

module Displayable
  def display_busted_message
    if player.busted?
      puts "You busted! #{red('Dealer wins')}."
    else
      puts "Dealer busted! #{green('You win')}."
    end
  end

  def display_winner
    if player.total > dealer.total
      puts green("You win!").to_s
    elsif dealer.total > player.total
      puts red("Dealer wins!").to_s
    else
      puts yellow("It's a tie!").to_s
    end
  end

  def display_all_cards
    player.show_cards
    dealer.show_cards
  end
end

class Card
  SUITS = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
  FACES = ('2'..'10').to_a + ['Jack', 'Queen', 'King'] + ['Ace']

  attr_reader :suit, :face

  def initialize(suit, face)
    @suit = suit
    @face = face
  end

  def ace?
    face == 'Ace'
  end

  def to_s
    "The #{face} of #{suit}"
  end
end

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::FACES.each do |face|
        @cards << Card.new(suit, face)
      end
    end

    shuffle
  end

  def shuffle
    cards.shuffle!
  end

  def deal_one
    cards.pop
  end
end

class Participant
  attr_accessor :cards, :name

  def initialize
    @cards = []
    set_name
  end

  def hit(deck)
    cards << deck.deal_one
    puts "#{name} chose to hit!"
    show_cards
  end

  def total
    total = cards.each.inject(0) do |sum, card|
      case card.face
      when :ace? then sum + 11
      when 'Jack', 'Queen', 'King' then sum + 10
      else
        sum + card.face.to_i
      end
    end

    cards.select(&:ace?).count.times { total -= 10 if total > 21 }
    total
  end

  def busted?
    total > 21
  end

  def show_cards
    puts ""
    puts "#{name}'s cards:"
    cards.each do |card|
      puts "- #{card}"
    end
    puts "For a total of #{total}."
    puts ""
  end
end

class Player < Participant
  def set_name
    @name = "Player"
  end

  def show_initial_cards
    puts "Player's cards:"
    cards.each do |card|
      puts "- #{card}"
    end
  end
end

class Dealer < Participant
  def set_name
    @name = "Dealer"
  end

  def show_initial_cards
    puts "Dealer's cards:"
    puts "- #{cards[0]}"
    puts "- <!> Hidden"
  end
end

class Game
  include Displayable

  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    loop do
      deal_cards
      show_initial_cards

      players_turn
      dealers_turn unless player.busted?

      show_result
      play_again? ? reset : break
    end
  end

  def deal_cards
    2.times do
      player.cards << deck.deal_one
      dealer.cards << deck.deal_one
    end
  end

  def show_initial_cards
    puts ""
    puts "-" * 20
    dealer.show_initial_cards
    player.show_initial_cards
    puts "-" * 20
    puts ""
  end

  # rubocop:disable Metrics/MethodLength
  def players_turn
    loop do
      print "=> Hit or stay? "
      player_input = ''
      loop do
        player_input = gets.chomp.downcase
        break if player_input == 'hit' || player_input == 'stay'
        print "Error! You must enter 'hit' or 'stay': "
      end

      player.hit(deck) if player_input == 'hit'
      break if player_input == 'stay' || player.busted?
    end
  end
  # rubocop:enable Metrics/MethodLength

  def dealers_turn
    loop do
      break if dealer.total >= 17

      dealer.hit(deck)
    end
  end

  def show_result
    if player.busted? || dealer.busted?
      display_busted_message
    else
      display_all_cards
      display_winner
    end
  end

  def play_again?
    print "=> Do you want to play again? (Y/N): "
    answer = gets.chomp.downcase
    answer.start_with?('y')
  end

  def reset
    self.deck = Deck.new
    player.cards = []
    dealer.cards = []
  end
end

Game.new.start
