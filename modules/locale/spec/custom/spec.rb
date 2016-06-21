require 'spec_helper'

describe 'locale:custom' do

  describe file('/etc/default/locale') do
    its(:content) { should match /LANG="pl_PL\.UTF-8"/ }
  end

end
