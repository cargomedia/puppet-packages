require 'open3'
require 'event_emitter'
require 'json'

module PuppetModules
  class Result

    attr_accessor :spec_results

    def initialize
      @spec_results = []
    end

    def summary
      @spec_results.reduce Hash.new do |memo, result|
        summary = result.summary || {}
        memo.merge summary do |key, oldval, newval|
          oldval + newval
        end
      end
    end

  end

  class SpecRunner
    include EventEmitter

    class SpecResult

      attr_reader :status, :output

      def initialize(status, output)
        @status = status
        @output = output
      end

      def summary
        @output['summary']
      end
    end

    def initialize(specs = [])
      @specs = specs
      on :stderr do |data|
        $stderr.puts data
      end
    end

    def add_spec(spec)
      @specs.push(spec)
    end

    def run
      result = Result.new
      @specs.each do |spec|
        spec.get_module.operatingsystem_support.each do |data|
          data['operatingsystemrelease'].each do |osrelease|
            spec_result = run_specific(spec, data['operatingsystem'], osrelease)
            result.spec_results.push(spec_result)
          end
        end
      end
      result
    end

    def run_specific(spec, os, osrelease)
      box = map_os_to_box(os, osrelease)
      command = "box=#{box} bundle exec rspec --format json #{spec.file.to_s}"
      output = {:stdout => '', :stderr => '', :combined => ''}
      status = nil

      Open3.popen3(command) do |stdin, stdout, stderr, wait_thr|
        stdin.close

        streams_read_open = [stdout, stderr]
        begin
          streams_read_available, _, _ = IO.select(streams_read_open)

          streams_read_available.each do |stream|
            if stream.eof?
              stream.close
              streams_read_open.delete(stream)
            else
              data = stream.readpartial(4096)
              if stdout === stream
                emit(:stdout, data)
                output[:stdout] += data
              end
              if stderr === stream
                emit(:stderr, data)
                output[:stderr] += data
              end
              output[:combined] += data
              emit(:output, data)
            end
          end
        end until streams_read_open.empty?
        status = wait_thr.value
      end
      SpecResult.new(status, JSON.parse(output[:stdout]))
    end

    def map_os_to_box(operatingsystem, release)
      boxes = {
        'Debian' => {
          '7' => 'wheezy'
        }
      }
      raise "No box found for #{operatingsystem} #{release}" unless boxes[operatingsystem] && boxes[operatingsystem][release]
      boxes[operatingsystem][release]
    end
  end
end
