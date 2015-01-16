require 'spec_helper'

describe command('/usr/local/composer/phpunit/phpunit/phpunit --version') do
  it { should return_exit_status 0 }
  its(:stdout) { should match /PHPUnit 4\.4\.0 / }
end
