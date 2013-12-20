require 'spec_helper'

describe group('gearmand') do
  it { should exist }
end

describe command('/usr/local/sbin/gearmand --version') do
  its(:stdout) { should match('1.1.2') }
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
