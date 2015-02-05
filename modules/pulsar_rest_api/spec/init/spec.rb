require 'spec_helper'

describe user('pulsar-rest-api') do
  it { should have_home_directory '/home/pulsar-rest-api' }
end

describe package('pulsar-rest-api') do
  it { should be_installed.by('npm') }
end

describe port(8080) do
  it { should be_listening }
end

describe port(80) do
  it { should be_listening }
end

describe command('curl -L localhost') do
  it { should return_exit_status 0 }
  its(:stdout) { should match '<title>Pulsar REST API client</title>' }
end
