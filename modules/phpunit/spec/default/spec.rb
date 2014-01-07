require 'spec_helper'

describe command('which phpunit') do
  it { should return_exit_status 0 }
end

describe command('phpunit --version') do
  it { should return_stdout /3\.7\.27/}
end
