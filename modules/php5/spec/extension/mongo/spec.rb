require 'spec_helper'

describe 'php5::extension::mongo' do

  describe command('php --ri mongo') do
    its(:exit_status) { should eq 0 }
  end
end
