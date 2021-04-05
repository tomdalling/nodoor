module Nodoor
  class Repo
    DEFAULT_SIDECAR_METADATA_EXT = '.nodoor_metadata.yml'

    def initialize(
      base_directory,
      file_system: FileSystem.default,
      sidecar_metadata_ext: DEFAULT_SIDECAR_METADATA_EXT
    )
      @base_directory = Pathname.new(base_directory)
      @file_system = file_system
      @sidecar_metadata_ext = sidecar_metadata_ext
    end

    def each
      return enum_for(__method__) unless block_given?

      file_system.each_file_under(base_directory) do |path|
        next if hidden?(path)
        next if path.end_with?(sidecar_metadata_ext)

        relative_path = Pathname(path).relative_path_from(base_directory)
        yield fetch(relative_path)
      end
    end

    def fetch(record_path)
      Record.new(record_path, repo: self)
    end

    def metadata_for(record_path)
      full_path = base_directory / record_path
      sidecar_path = full_path.sub_ext(full_path.extname + sidecar_metadata_ext)
      load_sidecar(sidecar_path) || load_frontmatter(full_path)
    end

    private

      attr_reader :base_directory, :file_system, :sidecar_metadata_ext

      def hidden?(path)
        File.basename(path).start_with?('.')
      end

      def load_frontmatter(path)
        file_system.open(path) do |f|
          Frontmatter.read(f)
        end
      end

      def load_sidecar(path)
        return nil unless file_system.exist?(path)
        YAML.safe_load(file_system.read(path))
      end
  end
end
