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
      def examples_summary_hash
        initial = {
          'duration' => 0,
          'example_count' => 0,
          'failure_count' => 0,
          'pending_count' => 0,
        }
        @spec_result_list.reduce initial do |memo, spec_result|
          memo.merge spec_result.summary_hash do |key, oldval, newval|
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
        examples_summary = examples_summary_hash

        duration = examples_summary['duration'].floor
        lines << 'Finished in ' + ChronicDuration.output(duration, :keep_zero => true) + '.'

        headline = success? ? 'Success!'.green : 'Failure!'.red
        spec_total_count = @spec_result_list.count
        spec_failures = @spec_result_list.reject(&:success?)
        examples_total_count = examples_summary['example_count']
        examples_failure_count = examples_summary['failure_count']
        headline << " #{spec_total_count} specs run, #{spec_failures.count} failures (#{examples_total_count} examples, #{examples_failure_count} failures)"
        lines << headline.bold

        lines << "Failed examples:\n" unless success?
        failed_specs.each do |spec_result|
          spec_result.failed_examples.each do |example|
            lines << example['full_description'].indent(4)
          end
        end
        lines << "\n"
        lines.join("\n")
      end
    end

    class SpecResult

      attr_reader :spec, :os, :stdout

      # @param [Spec] spec
      # @param [String] os
      # @param [Number] status
      # @param [String] stdout
      def initialize(spec, os, status, stdout)
        @spec = spec
        @os = os
        @status = status
        @stdout = JSON.parse(stdout.lines.to_a.last)
      end

      # @return [TrueClass, FalseClass]
      def success?
        @status == 0 && failed_examples.count == 0
      end

      # @return [Hash]
      def summary_hash
        @stdout['summary']
      end

      # @return [String]
      def summary
        headline = [
          success? ? 'Success!'.green : 'Failure!'.red,
          @stdout['summary_line']
        ].join(' ').bold

        lines = []
        lines << headline
        lines << "Failed examples:\n" unless success?
        failed_examples.each do |example|
          example_lines = []
          example_lines << example['full_description']
          unless example['exception'].nil?
            exception = example['exception']
            example_lines << exception['class'] + ':'
            example_lines << exception['message'].indent(2)
          end
          lines << example_lines.join("\n").indent(4)
        end
        lines << "\n"
        lines.join("\n")
      end

      # @return [Hash[]]
      def failed_examples
        @stdout['examples'].select do |example|
          example['status'] === 'failed'
        end
      end
    end


    include EventEmitter

    attr_accessor :filter_os_list

    def initialize
      @specs = []
      @filter_os_list = nil
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
          example_result = run_spec_in_box(spec, os)
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

      command = ['bundle', 'exec', 'rspec', '--format', 'json', spec.file.to_s]
      process = Komenda.create(command, { :env => env })
      runner = self
      process.on :stderr do |data|
        runner.emit(:output, data)
      end
      result = process.run
      SpecResult.new(spec, box, result.status, result.stdout)
    end
  end
end
