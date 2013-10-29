require 'spec_helper'

describe port(80) do
  it { should be_listening }
end

describe port(443) do
  it { should be_listening }
end

describe command('curl localhost/admin/install.php -L -H "Host: example.com"') do
  its(:stdout) { should match 'OpenX' }
end
