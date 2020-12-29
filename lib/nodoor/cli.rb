module Nodoor
  module CLI
    def self.run(argv = ARGV)
      repo = Repo.new(Dir.pwd)
      repo.query.each do |entry|
        puts entry.path
      end
    end
  end
end
