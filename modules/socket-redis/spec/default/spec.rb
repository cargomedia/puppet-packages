require 'spec_helper'

describe package('socket-redis') do
  it { should be_installed.by('npm') }
end
