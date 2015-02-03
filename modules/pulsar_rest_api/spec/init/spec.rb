require 'spec_helper'

describe package('pulsar-rest-api') do
  it { should be_installed.by('npm') }
end

describe port(8080) do
  it { should be_listening }
end

describe user('pulsar-rest-api') do
  it { should have_home_directory '/home/pulsar-rest-api' }
end
