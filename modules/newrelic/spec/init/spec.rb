require 'spec_helper'

describe package('newrelic-daemon') do
  it { should be_installed }
end

describe command('monit summary') do
  its(:stdout) { should match /Process 'newrelic-daemon'/ }
end
