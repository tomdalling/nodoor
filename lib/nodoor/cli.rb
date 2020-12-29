module Nodoor
  module CLI
    extend Dry::CLI::Registry

    register 'list', CLI::ListCommand
    register 'meta', CLI::MetaCommand

    def self.run(argv = ARGV)
      Dry::CLI.new(self).call(arguments: argv)
    end
  end
end
