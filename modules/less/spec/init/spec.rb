require 'spec_helper'

describe package('less') do
  it { should be_installed.by('npm') }
end

describe command('which lessc') do
  it { should return_exit_status 0 }
end
