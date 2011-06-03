module NoPhone

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

  def unmsisdnize(number)
    normalize("+#{number}") if number
  end

  def valid?(number)
    return false if number.nil?
    return false if number == ""
    case number.strip
    when /\A\+?[0-9[:space:]]+\z/
      return true
    end
    false
  end

  # Norway-centric. True if not a norwegian number.
  def international?(number)
    !!(normalize(number) =~ /^\+/)
  end
end
