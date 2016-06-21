require 'spec_helper'

describe 'puppetserver::environment' do

  describe file('/etc/puppetlabs/code/environments/foo/modules/mysql/metadata.json') do
    its(:content) { should match /name": "puppetlabs-mysql"/ }
  end

end
