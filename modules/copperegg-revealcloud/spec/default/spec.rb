require 'spec_helper'

describe command('/usr/local/revealcloud/revealcloud -V') do
  it { should return_exit_status 0 }
end

describe file('/etc/init.d/revealcloud') do
  it { should be_file }
end

describe service('revealcloud') do
  it { should be_enabled }
end

describe file('/etc/monit/conf.d/revealcloud') do
  it { should be_file }
end
