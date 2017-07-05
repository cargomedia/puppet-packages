require 'spec_helper'

describe 'php5::extension::redis' do

  describe command('php --ri redis') do
    its(:exit_status) { should eq 0 }
  end
end
