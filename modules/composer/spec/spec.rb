require 'spec_helper'

describe command('which composer') do
  it { should return_exit_status 0 }
end

describe 'PHP config parameters' do
  context  php_config('suhosin.executor.include.whitelist') do
    its(:value) { should eq 'phar' }
  end
end
