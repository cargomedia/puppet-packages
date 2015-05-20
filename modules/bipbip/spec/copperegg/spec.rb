require 'spec_helper'

describe 'bipbip' do

  describe file('/etc/bipbip/config.yml') do
    its(:content) { should match /storages:\n\s*-\n\s*name: copperegg\n\s*api_key: foo\n/ }
  end

end
