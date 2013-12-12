require 'spec_helper'

describe package('foreman-export-initd') do
  it { should be_installed.by('gem') }
end

describe command('which foreman-initd') do
  it { should return_exit_status 0 }
end
