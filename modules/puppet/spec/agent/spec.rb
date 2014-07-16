require 'spec_helper'

describe command('puppet agent --configprint server') do
  its(:stdout) { should match /^example.com$/ }
end

describe command('puppet agent --configprint runinterval') do
  its(:stdout) { should match /^120$/ }
end

describe command('puppet agent --configprint masterport') do
  its(:stdout) { should match /^8141$/ }
end

describe command('puppet agent --configprint splay') do
  its(:stdout) { should match /^true$/ }
end

describe command('puppet agent --configprint splaylimit') do
  its(:stdout) { should match /^120$/ }
end
