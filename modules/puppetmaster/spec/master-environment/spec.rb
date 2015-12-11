require 'spec_helper'

describe 'puppetmaster::environment' do

  describe file('/etc/puppet/environments/foo/modules/mysql/metadata.json') do
    its(:content) { should match /name": "puppetlabs-mysql"/ }
  end

end
