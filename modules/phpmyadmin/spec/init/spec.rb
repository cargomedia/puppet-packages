require 'spec_helper'

describe package('phpmyadmin') do
  it { should be_installed }
end

describe command('curl -L http://localhost/phpmyadmin') do
  its(:stdout) { should match '<title>phpMyAdmin </title>' }
end
