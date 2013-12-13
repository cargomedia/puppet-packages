require 'spec_helper'

describe package('php5-fpm') do
  it { should be_installed }
end
