require 'spec_helper'

describe 's3export_backup' do

  describe command('s3export') do
    its(:stderr) { should match /\[options\] <command> \[arguments\]/ }
  end

  describe file('/usr/local/lib/s3export_backup/resources/config/local.php') do
    it { should be_file }
    it { should contain("$awsVersion = 'foo-version'") }
    it { should contain("$awsRegion = 'foo-region'") }
    it { should contain("$awsBucket = 'foo-bucket'") }
    it { should contain("$awsKey = 'foo-key'") }
    it { should contain("$awsSecret = 'foo-secret'") }
  end
end
