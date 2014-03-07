require 'spec_helper'

describe command('php --ri apcu') do
  it { should return_exit_status 0 }
end
