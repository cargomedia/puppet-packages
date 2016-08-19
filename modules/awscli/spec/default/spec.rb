require 'spec_helper'

describe 'awscli' do

  describe command('pip freeze | grep -w -- \^awscli==.*') do
    its(:exit_status) { should eq 0 }
  end

  describe command('aws --version') do
    its(:exit_status) { should eq 0 }
  end
end
