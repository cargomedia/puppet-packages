require 'spec_helper'

describe 'php5::extension::curl' do

  describe command('php --ri curl') do
    its(:exit_status) { should eq 0 }
  end

end
