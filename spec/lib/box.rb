require 'pathname'

class Box

  # @param [Pathname, String] dir_outside
  def initialize(dir_outside)
    @dir_outside = Pathname.new(dir_outside) unless dir_outside.instance_of? Pathname
  end

  # @return [Pathname]
  def dir_inside
    Pathname.new('/opt/puppet-packages')
  end

  # @return [Pathname]
  def dir_outside
    @dir_outside
  end

  # @param [String] command
  def execute_command(command)
    result = Specinfra::Runner.run_command(command)
    if result.failure?
      raise "Command failed: #{command}\n\nSTDOUT:\n#{result.stdout}\n\nSTDERR:\n#{result.stderr}\n"
    end
  end

  # @param [Pathname, String] path
  # @return [Pathname]
  def parse_external_path(path)
    path = Pathname.new(path) unless path.instance_of? Pathname
    path = path.relative_path_from(dir_outside)
    raise 'Cannot parse path outside of working directory' if path.to_s.match(/^..\//)
    path.expand_path(dir_inside)
  end
end
