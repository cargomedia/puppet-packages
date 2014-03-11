require 'spec_helper'

describe file('/root/.composer/config.json') do
  it { should be_file }
  it { should be_owned_by 'root' }
end

describe command('composer config  --global --list') do
  its(:stdout) { should match /github-oauth.*github-token/ }
end
