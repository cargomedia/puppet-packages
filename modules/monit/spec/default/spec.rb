require 'spec_helper'

describe command('cat /proc/$(cat /var/run/monit.pid)/oom_score_adj') do
  it { should return_exit_status 0 }
  its(:stdout) { should match '-1000' }
end

describe process('monit') do
  it { should be_running }
end
