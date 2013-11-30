require 'spec_helper'

describe package('rdiff-backup') do
  it { should be_installed }
end

describe package('python') do
  it { should be_installed }
end

describe file('/etc/python2.6/sitecustomize.py') do
  it {should be_file }
end