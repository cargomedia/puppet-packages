require 'spec_helper'

describe command('puppet module list | grep puppetlabs-stdlib') do
  it { should return_exit_status 0 }
end
