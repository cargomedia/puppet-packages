require 'spec_helper'

describe 'puppetserver puppetfile' do

  describe file('/etc/puppetlabs/code/environments/production/modules/mysql/metadata.json') do
    its(:content) { should match /name": "puppetlabs-mysql"/ }
  end
end
