require 'spec_helper'

describe package('socket-redis') do
  it { should be_installed.by('npm') }
end

describe port(8085) do
  it { should be_listening }
end

describe port(8090) do
  it { should be_listening }
end
