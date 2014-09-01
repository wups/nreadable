Gem::Specification.new do |s|
  s.name        = 'nreadable'
  s.version     = '0.2.0'
  s.date        = '2014-08-29'
  s.summary     = "Create various readable representations of numeric values."
  s.description = <<-EOF
Extends the Numeric Class with the ability to create better readable
representations of numeric values as a String.
In the current version it supports thousands separated numbers
( e.g. 1,000,000 ) and an exponential notation with self-adjusting precision
( e.g. 1e+06 ).
EOF
  s.author      = "Markus Anders"
  s.files       = ["LICENSE", "Rakefile", "lib/nreadable.rb", "test/test_nreadable.rb"]
  s.homepage    = 'http://rubygems.org/gems/nreadable'
  s.license     = 'MIT'
end

