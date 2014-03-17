require 'spec_helper'

describe package('passenger') do
  it { should be_installed.by('gem').with_version('4.0.38') }
end

describe file('/etc/apache2/mods-enabled/passenger.load') do
  it { should be_file }
end

describe file('/etc/apache2/mods-available/passenger.conf') do
  it { should be_file }
end

describe port(80) do
  it { should be_listening }
end

describe command('sudo apache2ctl -M') do
  its(:stdout) { should match /passenger_module/ }
end
