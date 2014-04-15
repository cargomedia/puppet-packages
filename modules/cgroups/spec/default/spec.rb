require 'spec_helper'

describe package('cgroup-bin') do
  it { should be_installed }
end
