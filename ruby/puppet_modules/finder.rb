module PuppetModules

  class Finder

    class Spec

      attr_reader :name, :file

      def initialize(name, file)
        @name = name
        @file = file
      end
    end

    class Module

      attr_reader :name, :dir

      def initialize(name, dir)
        @name = name
        @dir = dir
      end

      def specs
        specs_dir = @dir.join('spec');
        Pathname.glob("#{@dir}/spec/**/spec.rb").map do |file|
          spec_dir_relative = file.relative_path_from(specs_dir).dirname
          name = spec_dir_relative.to_s.split('/').unshift(@name).join(':')
          Spec.new(name, file)
        end
      end

    end

    def initialize(modules_dir)
      @modules_dir = modules_dir
    end

    def modules
      @modules_dir.children.select { |c| c.directory? }.map do |module_dir|
        Module.new(module_dir.basename.to_s, module_dir)
      end
    end

    def specs
      modules.reduce [] do |memo, item|
        memo + item.specs
      end
    end
  end
end
