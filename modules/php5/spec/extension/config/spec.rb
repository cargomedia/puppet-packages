require 'spec_helper'

describe 'PHP config parameters' do
  context  php_config('foo.bar') do
    its(:value) { should eq 'bob' }
  end
end

describe file('/etc/php5/conf.d/foo.ini') do
  it { should be_file }
end
