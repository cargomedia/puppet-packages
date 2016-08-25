require 'spec_helper'

describe 'network::alias_ip_and_snat' do

  describe command('nc -lvnp 1337 -s 10.10.20.122 2>/tmp/stderr_output &') do
    its(:exit_status) { should eq 0}
  end

  describe command('curl --proxy '' --max-time 1 http://10.10.20.122:1337')  do
    its(:exit_status) { should eq 28}
  end

  describe file('/tmp/stderr_output') do
    its(:content) { should match /connect to+.+from+.+192\.168\.20\.122/}
  end
end
