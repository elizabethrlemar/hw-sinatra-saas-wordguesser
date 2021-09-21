class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def guess(letter)

    all_guesses = guesses + wrong_guesses

    if letter.nil? or !letter.match?(/[a-z]/i) or
      raise ArgumentError.new()
    elsif word.downcase.include? letter.downcase and !guesses.include? letter.downcase
      guesses.concat(letter.downcase)
    elsif !wrong_guesses.include? letter.downcase
     wrong_guesses.concat(letter.downcase)
    end

    !all_guesses.include? letter.downcase

  end



  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word.downcase
    @guesses = ""
    @wrong_guesses = ""
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesser.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
