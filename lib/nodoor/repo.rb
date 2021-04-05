module Nodoor
  class Repo
    def initialize(base_directory, file_system: FileSystem.default)
      @base_directory = Pathname.new(base_directory)
      @file_system = file_system
    end

    def each
      return enum_for(__method__) unless block_given?

      file_system.each_file_under(base_directory) do |path|
        # next unless File.file?(path)
        relative_path = Pathname(path).relative_path_from(base_directory)
        yield fetch(relative_path)
      end
    end

    def fetch(record_path)
      Record.new(record_path, repo: self)
    end

    def metadata_for(record_path)
      file_system.open(base_directory.join(record_path)) do |f|
        Frontmatter.read(f)
      end
    end

    private

      attr_reader :base_directory, :file_system
  end
end
