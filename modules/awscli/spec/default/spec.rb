require 'spec_helper'

describe command('pip freeze | grep -w -- \^awscli==1.3.9') do
  it { should return_exit_status 0 }
end

describe command('aws --version') do
  it { should return_exit_status 0 }
end
