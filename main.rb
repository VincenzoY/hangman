require './game.rb'
require './player.rb'
require 'fileutils'

class Hangman
  def initialize
    welcome
  end

  def welcome
    puts "Welcome to Hangman"
    puts "Would you like to start a new game (0) or load a previous save (1). To delete a file, load it but don't save it."
    choice = gets.chomp
    puts
    if choice == "0"
      puts "What's your name?"
      player = gets.chomp
      while player.length < 1 || !player.is_a?(String) || File.exists?("saves/#{player}.txt") do
        puts "That's not a valid name or it is already in use. Try again"
        player = gets.chomp
      end
      generate_word
      player = Player.new(player, @word, @guessed, Array.new, 0)
      Game.new(player)
    elsif choice == "1"
      puts "Which save would you like to load? (Type the Number). Press any key to start again."
      saves = File.readlines "saves.txt"
      saves.each_with_index do |line, index|
        next if index == 0
        columns = line.split("; ")
        @list = Array.new
        @list << "#{index}: #{columns[0]} (#{columns[2]})"
        puts @list
      end
      @choice = gets.chomp
      puts
      welcome if @choice.to_i == 0
      welcome if @list == nil
      while @choice.to_i > @list.length || @choice.to_i <= 0 || @choice.include?(".")do
        puts "That's not a valid number. Try again"
        @choice = gets.chomp
      end
      saves.each_with_index do |line, index|
        next unless index == @choice.to_i
        columns = line.split("; ")
        player = Player.new(columns[0], columns[1], columns[2].split(""), columns[3].split(""), columns[4].to_i)
        overwrite
        Game.new(player)
      end
    else
      puts "That's not a valid answer. Please try again"
      welcome
    end
  end

  def generate_word
    dictionary = File.readlines "5desk.txt"
    dictionary.each_with_index do |line, index|
      @word = dictionary[rand(dictionary.length)].chomp.downcase
    end
    @guessed = Array.new
    @word.length.times { @guessed << "_" }
    if @word.length < 6 || @word.length > 12
      generate_word
    end
  end

  def overwrite
    File.open('output.txt', 'w') do |out_file|
      File.foreach('saves.txt').with_index do |line,line_number|
      out_file.puts line unless line_number == @choice.to_i
      end
    end
    FileUtils.mv('output.txt', 'saves.txt')
  end
end

x = Hangman.new