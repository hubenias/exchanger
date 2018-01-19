require_relative '../exchanger'
require_relative '../lib/rate_record'
require 'date'

describe Exchanger do
  subject { described_class }
  before :all do
    Setup.new.init
  end

  after :all do
    Setup.new.clean
  end

  describe '.exchange' do
    context 'for one date' do
      it 'exchanges properly' do
        date = Date.today
        rate = 1.1
        RateRecord.instance.create(date.to_s, rate)
        result = subject.exchange(1, date)
        expect(result).to eq(rate)
      end
    end
  end
end