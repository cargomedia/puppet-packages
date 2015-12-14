require 'spec_helper'

describe 'puppetmaster puppetfile' do

  describe file('/etc/puppet/modules/mysql/metadata.json') do
    its(:content) { should match /name": "puppetlabs-mysql"/ }
  end
end
