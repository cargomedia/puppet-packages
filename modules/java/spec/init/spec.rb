require 'spec_helper'

describe command('java -version') do
  it { should return_exit_status 0 }
end

describe command('ls -d /usr/lib/jvm/java-7-openjdk*') do
  it { should return_exit_status 0 }
end
