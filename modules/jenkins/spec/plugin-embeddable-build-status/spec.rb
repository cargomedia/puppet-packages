require 'spec_helper'

describe file('/var/lib/jenkins/plugins/embeddable_build_status.hpi') do
  it { should be_file }
end
