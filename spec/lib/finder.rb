require 'json'

module PuppetModules

  class Finder

    class Spec
      attr_reader :name, :file, :puppet_module

      # @param [Module] puppet_module
      # @param [String] name
      # @param [Pathname] file
      def initialize(puppet_module, name, file)
        @puppet_module = puppet_module
        @name = name
        @file = file
      end
    end

    class Module
      attr_reader :name, :dir

      # @param [String] name
      # @param [Pathname] dir
      def initialize(name, dir)
        @name = name
        @dir = dir
      end

      # @return [Spec[]]
      def specs
        specs_dir = @dir.join('spec')
        Pathname.glob("#{@dir}/spec/**/spec.rb").map do |file|
          spec_dir_relative = file.relative_path_from(specs_dir).dirname
          name = spec_dir_relative.to_s.split('/').unshift(@name).join(':')
          Spec.new(self, name, file)
        end
      end

      # @return [Hash]
      def metadata
        JSON.parse(@dir.join('metadata.json').read) rescue raise 'Cannot load metadata'
      end

      # @return [String[]]
      def supported_os_list
        metadata['operatingsystem_support'].flat_map do |item|
          item['operatingsystemrelease'].map do |release|
            item['operatingsystem'] + '-' + release
          end
        end
      end
    end

    # @param [Pathname] modules_dir
    def initialize(modules_dir)
      @modules_dir = modules_dir
    end

    # @param [String] name
    # @return [Boolean]
    def puppet_module?(name)
      @modules_dir.join(name).directory?
    end

    # @param [String] name
    # @return [Module]
    def puppet_module(name)
      module_dir = @modules_dir.join(name)
      raise "Module #{name} not found" unless module_dir.directory?
      Module.new(name, module_dir)
    end

    # @return [Module[]]
    def puppet_modules
      @modules_dir.children.select { |c| c.directory? }.map do |module_dir|
        Module.new(module_dir.basename.to_s, module_dir)
      end
    end

    # @return [Spec[]]
    def specs
      puppet_modules.reduce [] do |memo, item|
        memo + item.specs
      end
    end
  end
end
