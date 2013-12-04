require 'spec_helper'

describe package('puppetmaster') do
  it { should be_installed }
end

describe port(8140) do
  it { should be_listening }
end
