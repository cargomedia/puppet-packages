require 'spec_helper'

describe 'locale' do

  describe file('/etc/default/locale') do
    its(:content) { should match /LANG="en_US\.UTF-8"/ }
  end

end
