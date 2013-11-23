require 'spec_helper'

describe package('newrelic-php5') do
  it { should be_installed }
end

describe command('php --re newrelic') do
  it { should return_exit_status 0 }
end

describe command('monit summary') do
  its(:stdout) { should match /Process 'newrelic-php5'/ }
end
