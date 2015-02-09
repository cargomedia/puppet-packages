require 'spec_helper'

describe package('less') do
  it { should be_installed.by('npm') }
end

describe command('which lessc') do
  its(:exit_status) { should eq 0 }
end
