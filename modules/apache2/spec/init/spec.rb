require 'spec_helper'

describe 'apache2' do

  describe package('apache2') do
    it { should be_installed }
  end

  describe file('/etc/apache2/sites-enabled/000-default') do
    it { should_not exist}
  end
end
