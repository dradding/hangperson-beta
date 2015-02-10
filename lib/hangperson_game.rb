class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  def initialize(new_word)
  	@word = new_word
  	@guesses = ''
  	@wrong_guesses = ''
    @word_with_guesses = ''
    set_word_with_guesses
  end

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :word_with_guesses

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(letter)
    if not /^[a-zA-z]$/.match(letter)
      raise(ArgumentError)
    else
    	if not (guesses.include? letter or wrong_guesses.include? letter)
    	  if word.include? letter
    	    guesses << letter
          update(letter)
        else
    	    wrong_guesses << letter
    	  end
    	else
    	  false
    	end
    end
  end

  def set_word_with_guesses
    word.each_char do |c|
      word_with_guesses << '-'
    end
  end

  def update(letter)
    counter = 0
    word.each_char do |c|
      if c.include? letter
        word_with_guesses[counter] = letter
      end
      counter = counter + 1
    end
  end

  def check_win_or_lose
    if word == word_with_guesses
      :win
    elsif wrong_guesses.length >= 7
      :lose
    else
      :play
    end
  end
end