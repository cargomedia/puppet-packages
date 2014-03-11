require 'spec_helper'

describe command('java -version') do
  it { should return_exit_status 0 }
end

describe command('ls -d /usr/lib/jvm/java-6-openjdk*') do
  it { should return_exit_status 0 }
  its(:stderr) { should match /java-6-openjdk/ }
end
