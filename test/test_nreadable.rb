require 'test/unit'
require 'nreadable'

class NreadableTest < Test::Unit::TestCase
    def test_delimited_int
        assert_equal "0", 0.delimited
        assert_equal "999", 999.delimited
        assert_equal "1,234,567", 1234567.delimited
        assert_equal "-1,000", -1000.delimited
        assert_equal "-100", -100.delimited
    end

    def test_delimited_float
        assert_equal "1.234", 1.234.delimited
        assert_equal "1,234.5678", 1234.5678.delimited
        assert_equal "-1,000.1", -1000.1.delimited
        assert_equal "Infinity", Float::INFINITY.delimited
        assert_equal "-Infinity", (-Float::INFINITY).delimited
    end

    def test_scientific_int
        assert_equal "0", 0.scientific
        assert_equal "1.234567e+06", 1234567.scientific
        assert_equal "-1.234567e+06", -1234567.scientific
        assert_equal "999", 999.scientific
        assert_equal "1e+03", 1000.scientific
        assert_equal "1.1e+03", 1100.scientific
        assert_equal "-999", -999.scientific
        assert_equal "-1e+03", -1000.scientific
    end

    def test_scientific_float
        assert_equal "0.01", 0.01.scientific
        assert_equal "9.11e-03", 0.00911.scientific
        assert_equal "-0.01", -0.01.scientific
        assert_equal "-9.11e-03", -0.00911.scientific
        assert_equal "1.234567e+03", 1234.567.scientific
        assert_equal "-1.234567e+03", -1234.567.scientific
        assert_equal "Infinity", Float::INFINITY.scientific
        assert_equal "-Infinity", (-Float::INFINITY).scientific
    end

    def test_si_prefixed_multi
        assert_equal "0", 0.si_prefixed
        assert_equal "999.999", 999.999.si_prefixed
        assert_equal "1k", 1000.si_prefixed
        assert_equal "1.23k", 1230.si_prefixed
        assert_equal "-999.999", -999.999.si_prefixed
        assert_equal "-1k", -1000.si_prefixed
        assert_equal "1Y", (10**24).si_prefixed
        assert_equal "1,000Y", (10**27).si_prefixed
        assert_equal "Infinity", Float::INFINITY.si_prefixed
        assert_equal "-Infinity", (-Float::INFINITY).si_prefixed
    end

    def test_si_prefixed_fraction
        assert_equal "10m", 0.01.si_prefixed
        assert_equal "-10m", -0.01.si_prefixed
        assert_equal "1m", 0.001.si_prefixed
        assert_equal "100µ", 0.0001.si_prefixed
        assert_equal "-100.1µ", -0.0001001.si_prefixed
        assert_equal "1y", (10**-24).si_prefixed
        assert_equal "1/10y", (10**-25).si_prefixed
    end

    def test_bin_prefixed
        assert_equal "0", 0.bin_prefixed
        assert_equal "1023.999", 1023.999.bin_prefixed
        assert_equal "1Ki", 1024.bin_prefixed
        assert_equal "-1023.999", -1023.999.bin_prefixed
        assert_equal "-1Ki", -1024.bin_prefixed
        assert_equal "Infinity", Float::INFINITY.bin_prefixed
        assert_equal "-Infinity", (-Float::INFINITY).bin_prefixed
    end

    def test_named_int
        assert_equal "0", 0.named
        assert_equal "999", 999.named
        assert_equal "1 thousand", 1000.named
        assert_equal "2 thousand", 1990.named
        assert_equal "-999", -999.named
        assert_equal "-1 thousand", -1000.named
        assert_equal "3.4 million", 3_430_000.named
        assert_equal "1 septillion", (10**24).named
        assert_equal "1,000 septillion", (10**27).named
    end

    def test_named_float
        assert_equal "0.5", 0.5.named
        assert_equal "0.004", 0.004.named
        assert_equal "999.999", 999.999.named
        assert_equal "2 thousand", 1999.99.named
        assert_equal "1.23456 thousand", 1234.56.named(5)
        assert_equal "Infinity", Float::INFINITY.named
        assert_equal "-Infinity", (-Float::INFINITY).named
    end
end

