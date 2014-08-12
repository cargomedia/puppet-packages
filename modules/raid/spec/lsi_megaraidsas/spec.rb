require 'spec_helper'

describe package('megaraid-status') do
  it { should be_installed }
end

describe command('monit summary') do
  its(:stdout) { should match /Process 'megaraidsas-statusd'/ }
end
