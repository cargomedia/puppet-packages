require 'spec_helper'

describe package('megaraid-status') do
  it { should be_installed }
end

describe file('/etc/monit/conf.d/megaraidsas-statusd') do
  it { should be_file }
end
