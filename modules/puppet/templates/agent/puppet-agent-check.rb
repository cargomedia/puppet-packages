#!/usr/bin/env ruby
require 'pathname'
require 'yaml'

agent_catalog_run = Pathname.new('/var/lib/puppet/state/agent_catalog_run.lock')
puppet_last_run_summary = Pathname.new('/var/lib/puppet/state/last_run_summary.yaml')

def error(message)
  $stderr.puts message
  exit 1
end

if agent_catalog_run.exist?
  if Time.new - agent_catalog_run.mtime > 3600
    error 'Puppet process is blocked for over an hour'
  end
  exit 0
end

unless puppet_last_run_summary.exist?
  error "#{puppet_last_run_summary.to_s} does not exist!"
end

puppet_report = YAML.load_file(puppet_last_run_summary)

report_age = Time.new.to_i - puppet_report['time']['last_run'].to_i
if report_age > 3600
  error 'Puppet agent did not update report for over an hour'
end

unless puppet_report.has_key?('events')
  error 'Missing `events` section in last-run-summary'
end

if puppet_report['events'] and puppet_report['events']['failure'].to_i > 0
  error 'Last puppet run finished with errors'
end

if puppet_report['resources'] and puppet_report['resources']['total'].to_i == 0
  error 'Last puppet run contained 0 resources.'
end
