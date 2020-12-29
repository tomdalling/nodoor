module Nodoor
  class CLI::MetaCommand < Dry::CLI::Command
    argument :record_path, type: :string

    def call(record_path:, args:)
      repo = Repo.new(Dir.pwd)
      record = repo.fetch(record_path)
      puts YAML.dump(record.metadata)
    end
  end
end
