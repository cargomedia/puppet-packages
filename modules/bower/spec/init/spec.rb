require 'spec_helper'

describe package('bower') do
  it { should be_installed.by('npm') }
end

describe command('bower --version') do
  its(:exit_status) { should eq 0 }
end
