#!/usr/bin/env ruby
require 'pathname'
require 'yaml'

agent_catalog_run = Pathname.new('/var/lib/puppet/state/agent_catalog_run.lock')
puppet_last_run_summary = Pathname.new('/var/lib/puppet/state/last_run_summary.yaml')

def error(message)
  $stderr.puts message
  exit 1
end

if agent_catalog_run.exist? then
  if Time.new - agent_catalog_run.mtime > 3600
    error 'Puppet process is blocked for over an hour'
  end
  exit 0
end

if puppet_last_run_summary.exist? then
  puppet_report = YAML.load_file(puppet_last_run_summary)
else
  error "#{puppet_last_run_summary.to_s} does not exist!"
end

report_age = Time.new.to_i - puppet_report['time']['last_run'].to_i
if report_age > 3600 then
  error 'Puppet agent did not update report for over an hour'
end

if puppet_report['events'] and puppet_report['events']['failure'].to_i > 0 then
  error 'Puppet catalog apply finished with errors'
end
