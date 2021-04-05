module Nodoor
  class Record
    attr_reader :path, :repo

    def initialize(path, repo:)
      @path = Pathname.new(path)
      @repo = repo
    end

    def metadata
      repo.metadata_for(path)
    end
  end
end
