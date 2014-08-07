require 'spec_helper'

describe file('/var/log/gearman-job-server/gearman-persist.sqlite3') do
  it { should_not be_file }
end

describe file('/etc/default/gearman-job-server') do
  it { should be_file }
  its(:content) { should_not match /^PARAMS=".*-q\s.*"$/ }
end

describe service('gearman-job-server') do
  it { should be_running }
end

describe port(4730) do
  it { should be_listening }
end
