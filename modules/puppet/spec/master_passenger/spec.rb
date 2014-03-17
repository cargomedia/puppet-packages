require 'spec_helper'

describe package('passenger') do
  it { should be_installed.by('gem') }
end

describe package('apache2') do
  it { should be_installed }
end

describe port(8140) do
  it { should be_listening }
end
