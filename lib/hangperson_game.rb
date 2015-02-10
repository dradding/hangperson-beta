class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  def initialize(new_word)
  	@word = new_word
  	@guesses = ''
  	@wrong_guesses = ''  
  end

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(letter)
  	if not (guesses.include? letter or wrong_guesses.include? letter)
  	  if word.include? letter
  	    guesses << letter
      else
  	    wrong_guesses << letter
  	  end
  	else
  	  false
  	end
  end
end