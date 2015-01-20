require 'spec_helper'

describe command('s3export') do
  # This is not testable until Serverspec 2.x
  its(:stderr) { should match '[options] <command> [arguments]' }
end

