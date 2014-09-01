# Adds the ability to create various readable representations of numbers to
# the Numeric Class.
class Numeric

  # Length of symbol arrays - 1.
  MAX_NREADABLE_EXP = 8

  # SI-Prefix symbols for positive exponents.
  SI_PREFIXES_BIG   = ['', 'k', 'M', 'G', 'T', 'P', 'E', 'Z', 'Y']

  # SI-Prefix symbols for negative exponents.
  SI_PREFIXES_SMALL = ['', 'm', 'µ', 'n', 'p', 'f', 'a', 'z', 'y']

  # Binary Prefix symbols for positive exponents.
  BINARY_PREFIXES   = ['', 'Ki', 'Mi', 'Gi', 'Ti', 'Pi', 'Ei', 'Zi', 'Yi']

  # English short scale names of numeric values. If you need a different
  # scale or language, just replace the content of this array.
  # Make sure it has MAX_NREADABLE_EXP + 1 fields.
  NUMBER_NAMING = ['', 'thousand', 'million', 'billion', 'trillion',
        'quadrillion', 'quintillion', 'sextillion', 'septillion']


  # Creates a better readable representation of the number by adding thousands
  # separators.
  # @param delimiter [String] the character(s) to use as the thousands
  #   separator.
  # @param separator [String] the character(s) to use as the decimal point.
  # @return [String] the number with thousands separator.
  # @example
  #   12345678.readable #=> "12,345,678"

  def delimited( delimiter = ',', separator = '.' )
    return self.to_s if self.is_a? Rational
    return self.to_s if self.is_a? Float and !self.finite?

    negative = self < 0
    result   = self.abs.to_s
    length   = result.length
    rounds   = 0
    decimal_position = result.index('.')

    pointer = if decimal_position
      result[decimal_position] = separator
      decimal_position - length - 4
    else
      -4
    end

    while pointer.abs <= length + rounds
      result.insert(pointer, delimiter)
      pointer -= 4
      rounds  += 1
    end

    result = "-" + result if negative
    result
  end


  # Creates a scientific representation of the number.
  # An exponential notation is used if the number is >= 1000 or < 0.01.
  # @param precision [Integer] the maximum precision. Only applies if the
  #   exponential notation is used. Must be >= 0.
  # @return [String] the formated number.
  # @example
  #   12.55.scientific #=> "12.55"
  #   10000.scientific #=> "1e+04"
  #   12345.scientific #=> "1.2345e+04"

  def scientific( precision = 6 )
    raise ArgumentError, "negative precision" if precision < 0
    return self.to_s if (self < 1000 and self >= 0.01) or (self == 0) or
        (self > -1000 and self <= -0.01)
    return self.to_s if self.is_a? Float and !self.finite?

    result = sprintf("%.#{ precision }e", self)
    position = result.index('e') - 1
    
    strip_insignificant_digits( result, position )
  end


  # Creates a representation of the number with a SI prefix attached.
  # @param precision [Integer] maximum precision. Must be >= 0.
  # @return [String] the formated number.
  # @example
  #   0.0000012.si_prefixed #=> "1.2µ"
  #   1000.si_prefixed #=> "1k"

  def si_prefixed( precision = 6 )
    raise ArgumentError, "negative precision" if precision < 0
    return self.to_s if (self < 1000 and self >= 1) or (self == 0) or
        (self > -1000 and self <= -1)
    return self.to_s if self.is_a? Float and !self.finite?

    number, exponent = base_and_exponent(1000)
    unit = if exponent >= 0
      SI_PREFIXES_BIG[exponent]
    else
      SI_PREFIXES_SMALL[exponent.abs]
    end

    result = nreadable_base_s( number, precision )
    result + unit
  end
  

  # Creates a representation of the number with a binary prefix attached.
  # @param precision [Integer] maximum precision. Must be >= 0.
  # @return [String] the formatted number.
  # @example
  #   1024.bin_prefixed #=> "1Ki"
  #   1_048_576.bin_prefixed + "B" #=> "1MiB" 

  def bin_prefixed( precision = 1 )
    raise ArgumentError, "negative precision" if precision < 0
    return self.to_s if self < 1024 and self > -1024
    return self.to_s if self.is_a? Float and !self.finite?

    number, exponent = base_and_exponent(1024)
    result = nreadable_base_s( number, precision )
    result + BINARY_PREFIXES[exponent]
  end


  # Creates a representation of the number using the short scale large-number
  # naming system with english words. You can change this by modifying the
  # NUMBER_NAMING constant.
  # @param precision [Integer] maximum precision. Must be >= 0.
  # @return [String] the formatted number.
  # @example
  #   2000.named #=> "2 tousand"
  #   2_310_000.named #=> "2.3 million"

  def named( precision = 1 )
    raise ArgumentError, "negative precision" if precision < 0
    return self.to_s if self < 1000 and self > -1000
    return self.to_s if self.is_a? Float and !self.finite?

    number, exponent = base_and_exponent(1000)
    result = nreadable_base_s( number, precision )
    "#{result} #{NUMBER_NAMING[exponent]}"
  end

  private

  # calculates the base and the exponent of self and returns it in an array.
  # @param base [Integer] base to use in the calculation.
  def base_and_exponent( base )
    return [0, 0] if self == 0

    f = self.to_f
    exponent = (Math.log(f.abs) / Math.log(base)).floor
    if exponent > MAX_NREADABLE_EXP
      exponent = MAX_NREADABLE_EXP
      number = self / (base ** exponent)
    elsif exponent < -MAX_NREADABLE_EXP
      exponent = -MAX_NREADABLE_EXP
      number = self / (base ** exponent)
    else
      number = (f / (base ** exponent)).round(8) #round to counter float errors
    end
    
    [number, exponent]
  end

  # converts number to string with given precision and thousands separator.
  def nreadable_base_s( number, precision )
    number = number.round(precision) if number.is_a? Float
    result = number.delimited
    strip_insignificant_digits(result) if number.is_a? Float

    result
  end

  # strips trailing zeros and the . if it's the last character
  def strip_insignificant_digits( string, index = nil )
    index = string.length - 1 if index.nil?

    while string[index] == '0' 
      string[index] = ''
      index -= 1
    end

    if string[index] == '.'
      string[index] = ''
    end

    string
  end

end

