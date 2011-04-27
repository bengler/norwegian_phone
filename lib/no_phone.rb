module NoPhone

  class << self
    def normalize(number)
      number ||= ""
      number = number.gsub(/[.\- \t\r\n\(\)]/, '')
      number.gsub!(/^(\+)(.*)/) { |m| $1 + $2.gsub(/\+/, '') }
      number.gsub!(/^00/, '+')
      number.gsub!(/^\+47/, '')
      number.gsub!(/^\+*0+/, '+')
      number.gsub!(/^47/, '') if number.size > 8
      number
    end

    def msisdnize(number)
      number = normalize(number)
      number = "47#{number}" unless number =~ /^\+/
      number.gsub!(/^\+/, '')
      number
    end
  end
end
