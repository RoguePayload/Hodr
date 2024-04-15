module ProfanityFilterController
  PROFANITY_WORDS = ['fuck', 'shit', 'bitch', 'asshole', 'etc.']

  def filter_profanity(text)
    PROFANITY_WORDS.each do |word|
      text.gsub!(/\b#{word}\b/i, '*' * word.length)
    end
    text
  end
end
