require 'spec_helper'

describe 'vagrant::plugin' do

  describe command('vagrant plugin list') do
    its(:stdout) { should match 'vagrant-phpstorm-tunnel' }
  end
end
