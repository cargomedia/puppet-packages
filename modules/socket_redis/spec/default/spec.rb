require 'spec_helper'

describe 'socket_redis' do

  describe package('socket-redis') do
    it { should be_installed.by('npm') }
  end

  describe service('socket-redis') do
    it { should be_running }
    it { should be_enabled }
  end

  describe port(8085) do
    it { should be_listening }
  end

  describe port(8090) do
    it { should be_listening }
  end

  describe port(8091) do
    it { should be_listening }
  end
end
