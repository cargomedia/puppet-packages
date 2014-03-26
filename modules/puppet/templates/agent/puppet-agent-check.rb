#!/usr/bin/env ruby
require 'yaml'

puppet_last_run_summary = "/var/lib/puppet/state/last_run_summary.yaml"
if File.exist?(puppet_last_run_summary) then
  puppet_report = YAML.load_file(puppet_last_run_summary)
else
  raise "#{puppet_last_run_summary} does not exist!"
end

report_age = Time.new.to_i - puppet_report['time']['last_run'].to_i
if report_age > 3600 then
  raise 'Puppet agent did not update report for over an hour'
end

if puppet_report['events'] and puppet_report['events']['failure'].to_i > 0 then
  raise 'Puppet catalog apply finished with errors'
end
