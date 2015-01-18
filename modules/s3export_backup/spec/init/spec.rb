require 'spec_helper'

describe command('s3export') do
  its(:stderr) { should match '[options] <command> [arguments]' }
end

