module Nodoor
  class Repo
    attr_reader :base_directory

    def initialize(base_directory)
      @base_directory = Pathname.new(base_directory)
    end

    def query
      Find.find(base_directory)
        .select { File.file?(_1) }
        .map { Pathname(_1).relative_path_from(base_directory) }
        .sort
        .map { Record.new(_1) }
    end

    def fetch(record_path)
      Record.new(record_path)
    end
  end
end
