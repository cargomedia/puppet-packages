require 'spec_helper'

describe package('foreman_debian') do
  it { should be_installed.by('gem') }
end

describe command('which foreman-debian') do
  it { should return_exit_status 0 }
end
