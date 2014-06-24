require 'spec_helper'
require 'json'

describe command('mongo --quiet --host localhost --port 27001 --eval "printjson(rs.status())"') do

  let(:status) {
    output = subject.stdout
    output.gsub!(/ISODate\((.+?)\)/, '\1 ')
    output.gsub!(/Timestamp\((.+?)\)/, '[\1]')
    output.gsub!(/ObjectId\((.+?)\)/, '1')
    JSON.parse(output)
  }

  let(:members) {
    status['members']
  }

  it 'repl has name' do
    status['set'].should eq('my-repl')
  end

  it 'contains one primary' do
    members.select { |m| m['stateStr'] == 'PRIMARY' }.count.should eq(1)
  end

  it 'contains one secondary' do
    primary = members.select { |m| m['stateStr'] == 'PRIMARY' }.first
    secondaries = members.select { |m| m['stateStr'] == 'SECONDARY' }

    secondaries.count.should eq(1)
    secondaries.first['syncingTo'].should eq(primary['name'])
  end

  it 'contains one arbiter' do
    arbiters = members.select { |m| m['stateStr'] == 'ARBITER' }

    arbiters.count.should eq(1)
    arbiters.first['name'].should eq('localhost:27003')
  end
end
