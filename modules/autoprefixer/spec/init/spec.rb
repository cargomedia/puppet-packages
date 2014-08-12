require 'spec_helper'

describe package('autoprefixer') do
  it { should be_installed.by('npm') }
end

describe command('autoprefixer --version') do
  it { should return_exit_status 0 }
  its(:stdout) { should match 'autoprefixer' }
end
