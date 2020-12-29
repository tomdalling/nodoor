module Nodoor
  class Record
    attr_reader :path

    def initialize(path)
      @path = Pathname.new(path)
    end

    def metadata
      path.open do |f|
        Frontmatter.read(f)
      end
    end
  end
end
