require 'spec_helper'

describe 'socket_redis' do

  describe package('socket-redis') do
    it { should be_installed.by('npm') }
  end

  describe service('socket-redis') do
    it { should be_running }
    it { should be_enabled }
  end

  describe port(7085) do
    it { should be_listening }
  end

  describe port(7090) do
    it { should be_listening }
  end

  describe port(7091) do
    it { should be_listening }
  end
end
