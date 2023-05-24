# Have the method letter_changes(str) take the str parameter being passed and modify it using the following algorithm.
# Replace every letter in the string with the 3rd letter following it in the alphabet
# (ie. c becomes f, Z becomes C).
# Then return this modified string.

=begin
  Breakdown
    - Every word in the given string has to be iterated over
    - Every letter in the word is to be replaced
    - The letter is replaced by the letter 3 spaces ahead of it
    - Only operate over alphabets and account for case
    - Input: String
    - Output: String

  Data structure
    - 'abc' > 'def'
    - a = 1, d = 4, 1 + 3
    - b = 2, 2 + 3 = 5, e = 5
    - 1, 2, 3 > 4, 5, 6
    - End of the string needs to repeat
    - English alphabets - 26
    - If letter_number + 3 > 26
     - new_letter_number = letter_number + 3 - 26
     - Z = 26, 26 + 3 - 26, 3 = c

  Problem
    - Iterate over each word
    - Iterate over each letter in the word
    - Replace each letter based on algorithm
    - Join the letters and words, return that as result

  Algorithm
    - Iterate over each word of the given string
      - Iterate over each letter of letter of the current word
      - If the letter is an alphabet
        - Replace the letter
      - Else return letter
      - Join the resultant array
    - Join the resultant array with spaces as separator

    - To replace the letter
      - If ALPHABET_NUMBERS[letter] + 3 > 26
        new_letter_number = ALPHABET_NUMBERS[letter] + 3 - 26
      - Else
        new_letter_number = ALPHABET_NUMBERS[letter] + 3
      - ALPHABET_NUMBER.key(new_letter_number)
=end

ALPHABETS = ('a'..'z').zip(1..26).to_h

def letter_changes(string)
  string.split.map do |word|
    word.chars.map do |letter|
      if ALPHABETS.keys.include?(letter.downcase)
        new_letter = change_letter(letter)
        letter.downcase == letter ? new_letter : new_letter.upcase
      else
        letter
      end
    end.join
  end.join(' ')
end

def change_letter(letter)
  letter_value = ALPHABETS[letter.downcase]
  if letter_value + 3 > 26
    ALPHABETS.key((letter_value - 26) + 3)
  else
    ALPHABETS.key(letter_value + 3)
  end
end

p letter_changes("this long cake@&") == "wklv orqj fdnh@&"
p letter_changes("Road trip9") == "Urdg wuls9"
p letter_changes("EMAILZ@gmail.com") == "HPDLOC@jpdlo.frp"
p letter_changes('xyz') == ('abc')
