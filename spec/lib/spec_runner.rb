require 'open3'
require 'event_emitter'
require 'json'
require 'colorize'
require 'chronic_duration'
require 'komenda'
require 'indentation'

module PuppetModules

  class SpecRunner


    class Result

      attr_accessor :spec_result_list

      def initialize
        @spec_result_list = []
      end

      # @return [Hash]
      def summary_data
        initial = {
          :duration => 0,
          :example_count => 0,
          :failure_count => 0,
        }
        @spec_result_list.reduce initial do |memo, spec_result|
          memo.merge spec_result.summary_data do |key, oldval, newval|
            oldval + newval
          end
        end
      end

      # @return [TrueClass, FalseClass]
      def success?
        @spec_result_list.all?(&:success?)
      end

      # @return [SpecResult[]]
      def failed_specs
        @spec_result_list.reject(&:success?)
      end

      # @return [String]
      def summary
        lines = []
        examples_summary = summary_data

        duration = examples_summary[:duration].floor
        lines << 'Finished in ' + ChronicDuration.output(duration, :keep_zero => true) + '.'

        headline = success? ? 'Success!'.green : 'Failure!'.red
        spec_total_count = @spec_result_list.count
        spec_failures = @spec_result_list.reject(&:success?)
        examples_total_count = examples_summary[:example_count]
        examples_failure_count = examples_summary[:failure_count]
        headline << " #{spec_total_count} specs run, #{spec_failures.count} failures (#{examples_total_count} examples, #{examples_failure_count} failures)"
        lines << headline.bold

        lines << "Failed examples:\n" unless success?
        failed_specs.each do |spec_result|
          spec_result.failed_examples.each do |example|
            lines << example.description.indent(4)
          end
        end
        lines << "\n"
        lines.join("\n")
      end
    end

    class SpecResult

      attr_accessor :success, :duration, :summary, :examples
      attr_reader :os

      # @param [String] os
      # @param [TrueClass, FalseClass] success
      def initialize(os, success)
        @os = os
        @success = success
        @duration = nil
        @summary = nil
        @examples = []
      end

      # @return [TrueClass, FalseClass]
      def success?
        @success === true and failed_examples.count == 0
      end

      # @return [Hash]
      def summary_data
        {
          :duration => @duration.to_i,
          :example_count => @examples.count,
          :failure_count => failed_examples.count,
        }
      end

      # @return [String]
      def summary
        headline = [
          success? ? 'Success!'.green : 'Failure!'.red,
          @summary.to_s
        ].join(' ').bold

        lines = []
        lines << headline
        lines << "Failed examples:\n" unless success?
        failed_examples.each do |example|
          example_lines = []
          example_lines << example.summary
          lines << example_lines.join("\n").indent(4)
        end
        lines << "\n"
        lines.join("\n")
      end

      # @return [Hash[]]
      def failed_examples
        examples.reject do |example|
          example.success?
        end
      end
    end


    class ExampleResult

      attr_reader :description, :stdout

      # @param [String] description
      # @param [TrueClass, FalseClass] success
      # @param [String] summary
      def initialize(description, success, summary)
        @description = description
        @success = success
        @summary = summary
      end

      # @return [TrueClass, FalseClass]
      def success?
        @success === true
      end

      # @return [String]
      def summary
        @description + "\n" + @summary
      end

      # @param [String] stdout
      # @return [ExampleResult]
      def self.from_stdout(stdout)
        description = stdout['full_description']
        summary_lines = []
        unless stdout['exception'].nil?
          exception = stdout['exception']
          summary_lines << exception['class'] + ':'
          summary_lines << exception['message'].indent(2)
        end
        summary = summary_lines.join("\n")
        status = stdout['status'] === 'passed'
        ExampleResult.new(description, status, summary)
      end
    end


    include EventEmitter

    attr_accessor :filter_os_list, :retries_on_failure

    def initialize
      @specs = []
      @filter_os_list = nil
      @retries_on_failure = ENV.has_key?('retries') ? ENV['retries'].to_i : 0
    end

    # @param [Spec[]]
    def add_specs(specs)
      @specs.concat(specs)
    end

    # @return [Result]
    def run
      emit(:output, "Filtering specs by operating systems: #{@filter_os_list.join(', ')}\n") unless @filter_os_list.nil?
      result = Result.new
      @specs.each do |spec|
        spec.puppet_module.supported_os_list.each do |os|
          next unless @filter_os_list.nil? or @filter_os_list.include? os
          emit(:output, "Running #{spec.name} for #{os}\n".bold)
          example_result = {}
          (@retries_on_failure+1).times do
              example_result = run_spec_in_box(spec, os)
              break if example_result.success?
              emit(:output, "Re-Running #{spec.name} for #{os}\n".bold)
          end
          emit(:output, example_result.summary)
          result.spec_result_list.push(example_result)
        end
      end
      result
    end

    # @return [SpecResult]
    def run_spec_in_box(spec, box)
      env = { 'box' => box }
      env['debug'] = ENV['debug'] if ENV.key?('debug')
      env['keep_box'] = ENV['keep_box'] if ENV.key?('keep_box')
      env['gui'] = ENV['gui'] if ENV.key?('gui')

      command = ['bundle', 'exec', 'rspec', '--format', 'json', spec.file.to_s]
      process = Komenda.create(command, { :env => env })
      runner = self
      process.on :stderr do |data|
        runner.emit(:output, data)
      end
      process_result = process.run

      spec_result = SpecResult.new(box, process_result.success?)
      begin
        stdout = JSON.parse(process_result.stdout.lines.to_a.last)
      rescue Exception => e
        spec_result.success = false
        spec_result.summary = "#{e.message}\nOutput:\n`#{process_result.output}`"
      else
        spec_result.duration = stdout['summary']['duration']
        spec_result.summary = stdout['summary']['summary_line']
        stdout['examples'].each do |example_stdout|
          spec_result.examples << ExampleResult.from_stdout(example_stdout)
        end
      end
      spec_result
    end
  end
end
