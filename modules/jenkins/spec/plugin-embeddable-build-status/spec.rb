require 'spec_helper'

describe file('/var/lib/jenkins/plugins/embeddable-build-status.hpi') do
  it { should be_file }
end
