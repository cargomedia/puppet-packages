require 'spec_helper'

describe command('monit summary') do
  its(:stdout) { should match /bipbip/ }
end

describe file('/etc/bipbip/services.d/monit.yml') do
  it { should be_file }
  its(:content) { should match /plugin:.*monit/ }
end
