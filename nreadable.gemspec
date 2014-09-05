Gem::Specification.new do |s|
  s.name        = 'nreadable'
  s.version     = '0.2.1'
  s.date        = '2014-09-05'
  s.summary     = "Create various readable representations of numeric values."
  s.description = <<-EOF
Extends the Numeric Class with the ability to create better readable
representations of numeric values as a String.
In the current version it supports thousands separated numbers,
an exponential notation with self-adjusting precision, SI-Prefixes,
Binary Prefixes and a large-number naming system.
EOF
  s.author      = "Markus Anders"
  s.files       = ["README.md", "LICENSE", "Rakefile", "lib/nreadable.rb", "test/test_nreadable.rb"]
  s.homepage    = 'http://github.com/wups/nreadable'
  s.license     = 'MIT'
end

