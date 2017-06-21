require 'spec_helper'

describe 'fluentd:source-logfile' do

  describe service('fluentd') do
    it { should be_running }
  end

  describe file('/var/lib/fluentd/logfile-simple_pos') do
    it { should be_file }
  end

  describe command('grep -rhE "message+.+foobar" /tmp/dump*') do
    its(:exit_status) { should eq 0 }
    its(:stdout) do
      is_expected.to include_json(
                       level: 'warning',
                       message: 'foobar',
                       hostname: /.+/,
                       journal: {
                         unit: 'simple.test',
                         logfile: '/tmp/simple.log',
                         transport: 'logfile'
                       },
                       extra: {
                         custom: '42'
                       }
                     )
    end
  end
end
