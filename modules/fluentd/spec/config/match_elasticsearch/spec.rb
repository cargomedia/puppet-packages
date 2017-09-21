require 'spec_helper'

describe 'fluentd::config::elasticsearch' do

  describe file('/etc/fluentd/config.d/50-match-elasticsearch-main.conf') do
    it { should be_file }

    content = <<-HEREDOC
<match **>
  @type elasticsearch
  hosts https://foo:bar@localhost:9200,https://foo:bar@localhost:9201
  type_name type-foo
  include_tag_key true
  logstash_format true
  time_precision 5
  buffer_type memory
  flush_interval 2
</match>
HEREDOC
    its(:content) { should eq content }
  end
end
