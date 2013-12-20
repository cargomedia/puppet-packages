require 'spec_helper'

describe command('/usr/local/sbin/gearmand --version') do
  its(:stdout) { should match('1.1.2') }
end

describe file('/etc/monit/conf.d/gearman-job-server') do
  it { should be_file }
end

describe service('gearman-job-server') do
  it { should be_enabled }
end

describe service('gearman-job-server') do
  it { should be_running }
end

describe port(4730) do
  it { should be_listening }
end
