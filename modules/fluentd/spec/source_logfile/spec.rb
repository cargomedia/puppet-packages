require 'spec_helper'

describe 'fluentd:source-logfile' do

  describe service('fluentd') do
    it { should be_running }
  end

  describe file('/var/lib/fluentd/logfile-simple_pos') do
    it { should be_file }
  end

  describe command('grep -rhE "message.:null" /tmp/dump*') do
    its(:exit_status) { should eq 1 }
  end

  describe command('grep -rhE "message.:.hey" /tmp/dump*') do
    its(:exit_status) { should eq 0 }
    its(:stdout) do
      is_expected.to include_json(
                       level: 'warning',
                       message: 'hey',
                       hostname: /.+/,
                       journal: {
                         transport: "syslog",
                         unit: /.+/,
                         pid: /\d+/,
                         uid: /\d+/
                       },
                       tag: 'journal'
                     )
    end
  end

  describe command('grep -rhE "message.:.foobar" /tmp/dump*') do
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
                       },
                       tag: 'logfile'
                     )
    end
  end

  describe command('grep -rhE "message.:.multifoo" /tmp/dump*') do
    its(:exit_status) { should eq 0 }
    its(:stdout) do
      is_expected.to include_json(
                       level: 'info',
                       message: 'multifoo',
                       hostname: /.+/,
                       journal: {
                         unit: 'multiline.test',
                         logfile: '/tmp/multiline.log',
                         transport: 'logfile'
                       },
                       extra: {
                         custom: 'val1',
                         foo: true,
                         bar: 42,
                         baz: 0.42,
                       },
                       tag: 'custom_tag'
                     )
    end
  end
end
