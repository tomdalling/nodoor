module Nodoor
  class CLI::ListCommand < Dry::CLI::Command
    def call
      repo = Repo.new(Dir.pwd)
      repo.each.sort_by(&:path).each do |record|
        puts record.path
      end
    end
  end
end
