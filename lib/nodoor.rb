# standard libs
require 'open3'
require 'find'

# gems
require 'zeitwerk'

# autoloading
Zeitwerk::Loader.for_gem.tap do |loader|
  loader.inflector.inflect(
    'cli' => 'CLI',
  )
  loader.setup
end
