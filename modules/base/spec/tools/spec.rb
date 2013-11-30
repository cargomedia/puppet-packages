require 'spec_helper'

describe package('vim') do
  it { should be_installed }
end

describe package('sysstat') do
  it { should be_installed }
end

describe package('screen') do
  it { should be_installed }
end

describe package('parallel') do
  it { should be_installed }
end

describe package('unp') do
  it { should be_installed }
end

describe package('tree') do
  it { should be_installed }
end

describe package('strace') do
  it { should be_installed }
end

describe package('links') do
  it { should be_installed }
end
