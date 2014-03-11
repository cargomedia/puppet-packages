require 'spec_helper'

describe command('vagrant plugin list') do
  its(:stdout) { should match 'vagrant-phpstorm-tunnel \(0.1.0\)' }
end
