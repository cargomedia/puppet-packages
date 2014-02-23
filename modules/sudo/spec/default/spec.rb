require 'spec_helper'

describe package('sudo') do
  it { should be_installed }
end

describe command('sudo -u foo sudo uname') do
  it { should return_exit_status 0 }
end
