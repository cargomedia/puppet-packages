require 'spec_helper'

describe package('libgearman7') do
  it { should be_installed }
end

describe package('libgearman-dev') do
  it { should be_installed }
end
