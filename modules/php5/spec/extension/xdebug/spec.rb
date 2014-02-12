require 'spec_helper'

describe command('php --re xdebug') do
  it { should return_exit_status 0 }
end
