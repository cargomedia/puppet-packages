require 'spec_helper'

describe 'php5::extension::memcache' do

  describe command('php --ri memcache') do
    its(:exit_status) { should eq 0 }
  end
end
