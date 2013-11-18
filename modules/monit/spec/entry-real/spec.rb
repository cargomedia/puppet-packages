require 'spec_helper'

describe file('/etc/monit/conf.d/puppet') do
  it { should be_file }
end
