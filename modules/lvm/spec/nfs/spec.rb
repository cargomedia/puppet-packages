require 'spec_helper'

describe package('lvm2') do
  it {should be_installed }
end

describe file('/nfsexport/shared') do
  it { should be_directory }
  it { should be_mode 707 }
  it { should be_owned_by 'nobody' }
  it { should be_grouped_into 'nogroup' }
end
