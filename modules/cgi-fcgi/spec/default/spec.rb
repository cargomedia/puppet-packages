require 'spec_helper'

describe package('libfcgi0ldbl') do
  it { should be_installed }
end

describe command('which cgi-fcgi') do
  it { should return_exit_status 0 }
end
