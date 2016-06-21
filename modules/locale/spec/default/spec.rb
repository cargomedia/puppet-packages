require 'spec_helper'

describe 'locale:default' do

  describe file('/etc/default/locale') do
    its(:content) { should match /LANG="en_US\.UTF-8"/ }
  end

end
