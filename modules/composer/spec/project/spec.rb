require 'spec_helper'

describe command('/usr/local/lib/phpunit/phpunit --version') do
  it { should return_exit_status 0 }
  its(:stdout) { should match /PHPUnit 4\.4\.0 / }
end
