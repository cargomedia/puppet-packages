require 'spec_helper'

describe service('mongodb-mms-monitoring-agent') do
  it { should be_enabled }
end
