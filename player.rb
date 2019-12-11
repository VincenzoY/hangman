class Player
  attr_accessor :word, :previous_guesses, :player, :guessed, :wrong, :tries

  def initialize(player, word, guessed, previous_guesses, wrong)
    @player = player
    @previous_guesses = previous_guesses
    @guessed = guessed
    @wrong = wrong
    @tries = 10
    @word = word
  end
end