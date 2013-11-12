require 'spec_helper'

describe package('arcconf') do
  it { should be_installed }
end

describe package('aacraid-status') do
  it { should be_installed }
end

describe command('arcconf') do
  its(:stdout) { should match /Adaptec by PMC/ }
end

describe command('monit summary') do
  its(:stdout) { should match /Process 'aacraid-statusd'/ }
end
