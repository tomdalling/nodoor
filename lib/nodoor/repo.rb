module Nodoor
  class Repo
    SIDECAR_METADATA_EXT = '.nodoor_metadata.yml'

    def initialize(base_directory, file_system: FileSystem.default)
      @base_directory = Pathname.new(base_directory)
      @file_system = file_system
    end

    def each
      return enum_for(__method__) unless block_given?

      file_system.each_file_under(base_directory) do |path|
        next if hidden?(path)
        next if path.end_with?(SIDECAR_METADATA_EXT)

        relative_path = Pathname(path).relative_path_from(base_directory)
        yield fetch(relative_path)
      end
    end

    def fetch(record_path)
      Record.new(record_path, repo: self)
    end

    def metadata_for(record_path)
      full_path = base_directory / record_path
      sidecar_path = full_path.sub_ext(full_path.extname + SIDECAR_METADATA_EXT)
      load_sidecar(sidecar_path) || load_frontmatter(full_path)
    end

    private

      attr_reader :base_directory, :file_system

      def hidden?(path)
        File.basename(path).start_with?('.')
      end

      def load_frontmatter(path)
        file_system.open(path) do |f|
          Frontmatter.read(f)
        end
      end

      def load_sidecar(sidecar_path)
        return nil unless file_system.exist?(sidecar_path)
        YAML.safe_load(file_system.read(sidecar_path))
      end
  end
end
