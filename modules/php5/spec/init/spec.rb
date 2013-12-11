require 'spec_helper'

describe package('php5-common') do
  it { should be_installed }
end

describe package('libapache2-mod-php5') do
  it { should_not be_installed }
end
