require 'spec_helper'

describe command('npm list socket-redis -g') do
  its(:stdout) { should match 'socket-redis@0.1.1' }
end

describe port(8085) do
  it { should be_listening }
end

describe port(8090) do
  it { should be_listening }
end
