require 'spec_helper'

describe package('sudo') do
  it { should be_installed }
end

describe command('sudo -u foo sudo uname') do
  its(:exit_status) { should eq 0 }
end
