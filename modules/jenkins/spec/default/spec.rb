require 'spec_helper'

describe package('jenkins') do
  it { should be_installed }
end

describe command('monit summary') do
  its(:stdout) { should match /Process 'jenkins'/ }
end
