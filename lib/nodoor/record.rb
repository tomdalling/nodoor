module Nodoor
  class Record
    attr_reader :path

    def initialize(path)
      @path = Pathname.new(path)
    end
  end
end
