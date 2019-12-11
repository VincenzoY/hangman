class Game
  def initialize(player)
    @player = player
    play_game
  end

  def play_game
    puts
    puts "Choose a letter"
    puts @player.guessed.join(" ")
    while (@player.wrong != @player.tries && @player.guessed.include?("_")) do
      letter = gets.chomp.downcase
      if letter == "1"
        break
      end
      while letter.length > 1 || !letter.is_a?(String) || letter == "" do
        puts "That's not a valid character. Try again."
        letter = gets.chomp.downcase
      end
      puts
      if @player.word.include?(letter)
        puts "Nice job! Keep on guessing"
        @player.guessed[@player.word.index(letter)] = letter
      else
        puts "Nice try! You'll get it next time"
      end
      puts @player.guessed.join(" ")
      unless @player.previous_guesses.include?(letter)
        @player.previous_guesses << letter 
        @player.wrong += 1
      end
      puts "Previous Guesses: #{@player.previous_guesses.join(", ")}"
      puts "You've guessed #{@player.wrong} letters wrong. You have #{@player.tries - @player.wrong} wrong guesses left"
      puts "Press (1) to save the game."
    end
    puts
    if letter == "1"
      save
    elsif @player.wrong == @player.tries || @player.guessed.include?("_")
      puts "Sorry you lost. Try again!"
    else
      puts "You won! Congrats"
    end
  end

  def save
    File.open("saves/#{@player.player}.txt", 'w') {|file| file.puts "test"}
  end
end