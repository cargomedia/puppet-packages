require 'spec_helper'

describe 'apt::update' do

  describe command('stat -c "%Y" /var/lib/apt/periodic/update-success-stamp') do
    let(:update_stamp) { subject.stdout.to_i }

    it 'should update indices' do
      expect(update_stamp).to be_within(10).of(Time.now.to_i)
    end
  end

end
