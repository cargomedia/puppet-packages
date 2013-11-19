require 'spec_helper'

describe user('satis') do
  it { should exist }
  it { should have_home_directory '/var/lib/satis' }
end

describe file('/var/lib/satis/satis/.git') do
  it { should be_directory }
  it { should be_owned_by 'satis' }
end

describe port(80) do
  it { should be_listening }
end

