class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def guess(letter)
    all_guesses = guesses + wrong_guesses

    if letter.nil? or !letter.match?(/[a-z]/i)
      raise ArgumentError.new()
    elsif word.downcase.include? letter.downcase and !guesses.include? letter.downcase
      guesses.concat(letter.downcase)
    elsif !wrong_guesses.include? letter.downcase
     wrong_guesses.concat(letter.downcase)
    end

    !all_guesses.include? letter.downcase
  end

  def word_with_guesses
    hangman = "-" * word.length

    word.split('').each { |word_letter|
      guesses.split('').each { |guess_letter|
        if word_letter == guess_letter
          hangman[word.index(guess_letter)]= guess_letter
          word[word.index(guess_letter)]= "-"
        end
      }
    }

    return hangman
  end

  def check_win_or_lose
    win_check = 0

    word.split('').each do |word_letter|
      if guesses.include? word_letter
        win_check += 1
      end
    end

    if win_check == word.length
      outcome = :win
    elsif wrong_guesses.length >= 7
      outcome = :lose
    else
      outcome = :play
    end
  end

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
