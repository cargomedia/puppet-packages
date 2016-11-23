require 'spec_helper'

describe 'vagrant::plugin versioned' do

  describe command('vagrant plugin list') do
    its(:stdout) { should match 'vagrant-proxyconf \(1.5.1\)' }
  end
end
