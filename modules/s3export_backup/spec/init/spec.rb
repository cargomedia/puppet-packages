require 'spec_helper'

describe command('s3export') do
  it { should return_exit_status 0 }
end

