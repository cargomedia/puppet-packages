require 'spec_helper'

describe 'raid' do

  describe command('facter raid') do
    its(:stdout) { should match /adaptec,sas2ircu/ }
  end

end
