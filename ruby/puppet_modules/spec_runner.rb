module PuppetModules
  class SpecRunner


    def initialize(specs = [])
      @specs = specs
    end

    def add_spec(spec)
      @specs.push(spec)
    end

    def run
      puts @specs.map(&:file).join("\n")
    end
  end
end
