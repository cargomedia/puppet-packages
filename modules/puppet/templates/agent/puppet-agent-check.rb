#!/usr/bin/env ruby
require 'pathname'
require 'yaml'

agent_catalog_run = Pathname.new('/var/lib/puppet/state/agent_catalog_run.lock')
puppet_last_run_summary = Pathname.new('/var/lib/puppet/state/last_run_summary.yaml')

def die(code = 0, message = '')
  $stderr.puts message if !message.empty?
  exit code
end

if agent_catalog_run.exist? then
  if Time.new - agent_catalog_run.mtime > 3600
    die 1, 'Puppet process is blocked for over an hour'
  end
  die
end

if puppet_last_run_summary.exist? then
  puppet_report = YAML.load_file(puppet_last_run_summary)
else
  die 1, "#{puppet_last_run_summary.to_s} does not exist!"
end

report_age = Time.new.to_i - puppet_report['time']['last_run'].to_i
if report_age > 3600 then
  die 1, 'Puppet agent did not update report for over an hour'
end

if puppet_report['events'] and puppet_report['events']['failure'].to_i > 0 then
  die 1, 'Puppet catalog apply finished with errors'
end
