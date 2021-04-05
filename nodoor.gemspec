require_relative 'lib/nodoor/version'

Gem::Specification.new do |spec|
  spec.name = 'nodoor'
  spec.version = Nodoor::VERSION
  spec.licenses = ['MIT']
  spec.summary = 'A "database" that consists of mostly text files in directories, with associated metadata.'
  spec.authors = ["Ruby Coder"]
  spec.email = 'tom' + '@' + 'tomdalling.com'
  spec.files = Dir['lib/**/*.rb']
  spec.homepage = 'https://github.com/tomdalling/nodoor'

  spec.add_runtime_dependency 'zeitwerk'
  spec.add_runtime_dependency 'dry-cli'

  spec.add_development_dependency 'test_bench'
  spec.add_development_dependency 'byebug'
end
