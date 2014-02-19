#/usr/bin/env ruby
require 'pathname'

last_summary = Pathname.new('/var/lib/puppet/state/last_run_summary.yaml')
raise "#{last_summary.to_s} does not exist!" unless last_summary.exist?
raise 'Puppet agent did not create report for over an hour' if Time.new - last_summary.mtime > 3600

