require 'spec_helper'

describe 'mysqltuner' do

  describe package('mysqltuner') do
    it { should be_installed }
  end
end
