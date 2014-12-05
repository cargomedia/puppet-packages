require 'spec_helper'

describe package('pulsar-rest-api') do
  it { should be_installed.by('npm') }
end

describe port(80) do
  it { should be_listening }
end

