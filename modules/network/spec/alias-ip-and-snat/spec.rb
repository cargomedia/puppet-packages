require 'spec_helper'

describe 'network::alias_ip_and_snat' do

  describe command('curl --proxy "" --max-time 1 http://10.10.20.122:1337')  do
    its(:exit_status) { should be_between(28,52)}
  end

  describe file('/tmp/stderr_output') do
    its(:content) { should match /[C|c]onnect+.+from+.+192\.168\.20\.122/}
  end
end
