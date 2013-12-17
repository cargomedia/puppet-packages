require 'spec_helper'

describe package('php5-fpm') do
  it { should be_installed }
end

describe command('monit summary | grep php5-fpm') do
  it { should return_exit_status 0 }
end
