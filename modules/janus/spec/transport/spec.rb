require 'spec_helper'

describe 'janus::plugins' do

  describe file('/etc/janus/janus.transport.http.cfg') do
    it { should be_file }
  end

  describe file('/etc/janus/janus.transport.websockets.cfg') do
    it { should be_file }
  end

  describe port (7017) do
    it {should be_listening}
  end

  describe port (1337) do
    it {should be_listening}
  end

end
