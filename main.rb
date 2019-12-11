require './game.rb'
require './player.rb'

class Hangman
  def initialize
    welcome
  end

  def welcome
    puts "Welcome to Hangman"
    puts "Would you like to start a new game (0) or load a previous save (1)"
    choice = gets.chomp
    puts
    if choice == "0"
      puts "What's your name?"
      player = gets.chomp
      while player.length < 1 || !player.is_a?(String) do
        puts "That's not a name. Try again"
        player = gets.chomp
      end
      player = Player.new(player, Array.new, Array.new, 0)
      Game.new(player)
    elsif choice == "1"
      load_game
    else
      puts "That's not a valid answer. Please try again"
      welcome
    end
  end

end

x = Hangman.new