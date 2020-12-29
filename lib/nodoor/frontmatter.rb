# frozen_string_literal: true

module Nodoor
  module Frontmatter
    extend self

    YAML_START_DOCUMENT_LINE = "---\n"
    YAML_END_DOCUMENT_LINE = "...\n"

    def read(io)
      return nil unless read_yaml_document_start(io)

      yaml = +""
      eof = false

      loop do
        next_line =
          begin
            io.readline
          rescue EOFError
            nil
          end

        break if next_line.nil?
        break if next_line == YAML_END_DOCUMENT_LINE

        yaml << next_line
      end

      YAML.safe_load(yaml)
    end

    private

      def read_yaml_document_start(io)
        old_pos = io.tell

        if io.readline == YAML_START_DOCUMENT_LINE
          true
        else
          io.seek(old_pos)
          false
        end
      rescue EOFError
        io.seek(old_pos)
        false
      end
  end
end
