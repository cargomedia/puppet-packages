require 'spec_helper'

describe file('/etc/monit/conf.d/alert') do
  its(:content) { should match /set alert/ }
end

describe command('monit-alert foobar') do
  it { should return_exit_status 1 }
end

describe command('monit-alert none') do
  it { should return_exit_status 0 }
end

describe file('/etc/monit/conf.d/alert') do
  its(:content) { should_not match /set alert/ }
end

describe command('monit-alert default') do
  it { should return_exit_status 0 }
end

describe file('/etc/monit/conf.d/alert') do
  its(:content) { should match /set alert/ }
end
