require 'spec_helper'

describe package('foreman-export-initd') do
  it { should be_installed.by('gem') }
end

describe command('foreman export initd /tmp/export -f /tmp/Procfile') do
  it { should return_exit_status 0 }
end

describe file('/tmp/export') do
  it { should be_directory }
end
