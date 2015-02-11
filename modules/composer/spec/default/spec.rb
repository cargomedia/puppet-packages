require 'spec_helper'

describe 'composer' do

  describe command('which composer') do
    its(:exit_status) { should eq 0 }
  end

  describe 'PHP config parameters' do
    context php_config('suhosin.executor.include.whitelist') do
      its(:value) { should eq 'phar' }
    end
  end
end
