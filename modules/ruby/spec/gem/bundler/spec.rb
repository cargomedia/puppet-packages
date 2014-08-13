require 'spec_helper'

describe package('bundler') do
  it { should be_installed.by('gem').with_version('1.6.4') }
end

describe command('bundle --version') do
  it { should return_exit_status 0 }
  its(:stdout) { should match 'Bundler version' }
end
