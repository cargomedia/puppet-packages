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

describe command('monit-silent foo bar') do
  it { should return_exit_status 1 }
end

describe command('monit-silent unmonitor root') do
  it { should return_exit_status 0 }
end

describe command('echo q | mail -u vagrant | grep monit | wc -l ') do
  it { should return_exit_status 0 }
  its(:stdout) { should match /1\n/ }
end


describe process('monit') do
  it { should be_running }
end
