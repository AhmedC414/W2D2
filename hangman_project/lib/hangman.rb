class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word
    @random_word = DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, "_" )
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    if @attempted_chars.include?(char)
      true
    else 
      false
    end
  end

  def get_matching_indices(char)
      indices = []
      @secret_word.each_char.with_index { |ele, i| indices << i if char == ele }
      indices
  end

  def fill_indices(char, indices)
    indices.each do |i|
      @guess_word[i] = char
    end
  end

  def try_guess(char)
    if self.already_attempted?(char)
      print "that has already been attempted"
      return false
    else
      self.attempted_chars << char
    end

    if self.get_matching_indices(char).empty?
      @remaining_incorrect_guesses -= 1
    else
      self.fill_indices(char, self.get_matching_indices(char))
    end
    true
  end

  def ask_user_for_guess
      print "Enter a char"
      input = gets.chomp
      self.try_guess(input)
  end

  def win?
      if @guess_word == @secret_word.split("")
        print "WIN"
        true
      else
        false
      end
  end

  def lose?
      if @remaining_incorrect_guesses == 0
        print "LOSE"
        true
      else
        false
      end
  end

  def game_over?
    if self.win?
      print @secret_word
      true
    elsif self.lose?
      print @secret_word
      true
    else
      false
    end
  end
    
end
