require 'spec_helper'

describe package('ntp') do
  it { should be_installed }
end

describe command('monit summary') do
  its(:stdout) { should match /ntp/ }
end
