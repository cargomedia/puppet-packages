require 'spec_helper'

describe 'gstreamer::tools' do

  describe command('gst-inspect-1.0 --version') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /GStreamer 1\.6\.1/ }
  end

end
