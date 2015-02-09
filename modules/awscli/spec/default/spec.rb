require 'spec_helper'

describe command('pip freeze | grep -w -- \^awscli==1.3.9') do
  its(:exit_status) { should eq 0 }
end

describe command('aws --version') do
  its(:exit_status) { should eq 0 }
end
