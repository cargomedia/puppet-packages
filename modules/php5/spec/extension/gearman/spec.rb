require 'spec_helper'

describe 'php5::extension::gearman' do

  describe command('php --ri gearman') do
    its(:exit_status) { should eq 0 }
  end
end
