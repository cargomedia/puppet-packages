require 'spec_helper'

describe command('s3export') do
  # This is not testable until Serverspec 2.x
  its(:stderr) { should match '[options] <command> [arguments]' }
end

describe file('/usr/local/lib/s3export_backup/resources/config/local.php') do
  it { should be_file }
  it { should contain("$awsBucket = 'foo-bucket'") }
  it { should contain("$awsRegion = 'foo-region'") }
  it { should contain("$awsKey = 'foo-key'") }
  it { should contain("$awsSecret = 'foo-secret'") }
end
