module Nodoor
  module FileSystem
    extend self

    def default
      self
    end

    def each_file_under(directory)
      return enum_for(__method__, directory) unless block_given?

      Find.find(directory.to_s) do |path|
        next unless File.file?(path)
        yield path
      end
    end

    def open(path, &block)
      File.open(path.to_s, &block)
    end
  end
end
