require 'spec_helper'

describe command('monit summary') do
  its(:stdout) { should match /cron/ }
end
