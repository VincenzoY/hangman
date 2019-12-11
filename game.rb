class Game
  def initialize(player)
    @player = player
    play_game
  end

  def play_game
    while (@player.wrong != @player.tries && @player.guessed.include?("_")) do
      puts
      puts "Choose a letter"
      puts @player.guessed.join(" ")
      puts "Previous Guesses: #{@player.previous_guesses.join(", ")}"
      puts "You've guessed #{@player.wrong} letters wrong. You have #{@player.tries - @player.wrong} wrong guesses left"
      puts "Press (1) to save the game."
      letter = gets.chomp.downcase
      if letter == "1"
        break
      end
      while letter.length > 1 || !letter.is_a?(String) || letter == "" || @player.previous_guesses.include?(letter) do
        puts "That's not a valid character or it is already used. Try again."
        letter = gets.chomp.downcase
      end
      puts
      if @player.word.include?(letter)
        puts "Nice job!"
        @player.guessed[@player.word.index(letter)] = letter
      else
        puts "Nice try!"
        @player.wrong += 1
      end
      @player.previous_guesses << letter 
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
      File.open("saves.txt", 'a'){|f| f.puts "#{@player.player}; #{@player.word}; #{@player.guessed.join}; #{@player.previous_guesses.join}; #{@player.wrong}"}
  end
end