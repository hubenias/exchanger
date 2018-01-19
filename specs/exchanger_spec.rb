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

    context 'for period' do
      it 'exchanges properly' do
        date = Date.new(2018, 01, 01)
        RateRecord.instance.create(date.to_s, 1.1)
        RateRecord.instance.create('2018-01-02', 1.2)
        date1 = Date.new(2018, 01, 03)
        RateRecord.instance.create(date1.to_s, 1.3)
        result = subject.exchange(2, [date, date1])
        expect(result).to eq([2.2, 2.4, 2.6])
      end
    end
  end
end