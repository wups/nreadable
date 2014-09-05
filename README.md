# nreadable
Extends the Numeric Class with the ability to create better readable representations of numeric values as a String.

    gem install nreadable

## Features
- thousands separated numbers ( e.g. 1,000,000 )
- exponential notation with self-adjusting precision ( e.g. 1e+06 )
- SI-Prefixes ( e.g. 1000000 = 1M )
- Binary Prefixes ( e.g. 1048576 = 1Mi )
- large-number naming system ( e.g. 1 million )

## Usage
    1000.delimited         #=> "1,000"
    123000000.scientific   #=> "1.23e+08"
    123000000.si_prefixed  #=> "123M"
    0.000123.si_prefixed   #=> "123µ"
    123000000.bin_prefixed #=> "117.3Mi"
    123000000.named        #=> "123 million"
for more details and options, see http://rubydoc.info/gems/nreadable/0.2.1/Numeric

## License
The MIT license. See LICENSE file.

