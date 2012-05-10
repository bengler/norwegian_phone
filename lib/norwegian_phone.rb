module NorwegianPhone

  class << self
    def normalize(number)
      number ||= ""
      number = number.gsub(/[.\- \t\r\n\(\)]/, '')
      number.gsub!(/^(\+)(.*)/) { |m| $1 + $2.gsub(/\+/, '') }
      number.gsub!(/^00/, '+')
      number.gsub!(/^\+47/, '')
      number.gsub!(/^\+*0+/, '+')
      number
    end

    def msisdnize(number)
      return nil if missing?(number)

      number = normalize(number)
      number = "47#{number}" unless number =~ /^\+/
        number.gsub!(/^\+/, '')
      number
    end

    def unmsisdnize(number)
      normalize("+#{number}") if number
    end

    def number_valid?(number)
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

    private

      def missing?(number)
        number.nil? || (number == "")
      end

  end
end
