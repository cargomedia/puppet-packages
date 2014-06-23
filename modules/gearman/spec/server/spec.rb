require 'spec_helper'

describe user('gearman') do
  it { should exist }
end

describe command('gearmand --version') do
  its(:stdout) { should match('1.1.12') }
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

describe command('monit summary') do
  its(:stdout) { should match /gearman-job-server/ }
end
