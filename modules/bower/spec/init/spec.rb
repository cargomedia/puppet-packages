require 'spec_helper'

describe package('bower') do
  it { should be_installed.by('npm') }
end

describe command('bower --version') do
  it { should return_exit_status 0 }
end
