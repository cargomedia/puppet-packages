require 'spec_helper'

describe file('/tmp/foo') do
  it { should be_file }
end

describe file('/tmp/bar') do
  it { should be_file }
end

describe file('/tmp/foo') do
  its(:content) {should match /two and a half/}
end

describe file('/tmp/bar') do
  its(:content) {should match /four and five/}
end
