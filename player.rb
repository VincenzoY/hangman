class Player
  attr_accessor :word, :previous_guesses, :player, :guessed, :wrong, :tries, :player

  def initialize(player, previous_guesses, guessed, wrong)
    @player = player
    @previous_guesses = previous_guesses
    @guessed = guessed
    @wrong = wrong
    @tries = 10
    generate_word
  end

  def generate_word
    dictionary = File.readlines "5desk.txt"
    dictionary.each_with_index do |line, index|
      @word = dictionary[rand(dictionary.length)]
    end
    (@word.length-1).times { @guessed << "_" }
    if @word.length < 6 || @word.length > 12
      generate_word
    end
  end
end