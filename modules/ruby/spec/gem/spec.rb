require 'spec_helper'

describe package('ruby') do
  it { should be_installed }
end

describe command('which gem') do
  it { should return_exit_status 0 }
end

describe command('gem list') do
  its(:stdout) { should match 'deep_merge' }
end

