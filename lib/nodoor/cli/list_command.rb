module Nodoor
  class CLI::ListCommand < Dry::CLI::Command
    def call
      repo = Repo.new(Dir.pwd)
      repo.query.each do |entry|
        puts entry.path
      end
    end
  end
end
