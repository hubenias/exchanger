require '../../lib/rate_record'
require '../../lib/setup'
require 'sqlite3'

describe RateRecord do
  subject { described_class.instance }
  before :all do
    Setup.new.init
  end

  after :all do
    Setup.new.clean
  end

  describe '#create' do
    it 'creates record in rates table' do
      table_name = described_class::TABLE_NAME
      subject.create('2010-01-05', '1.33')
      record = subject.conn.execute("select * from #{table_name};").first
      expect(record).to eq(['2010-01-05', '1.33'])
    end
  end

  describe '#read' do
    it 'returns record from rates table' do
      subject.create('2010-02-05', '1.5')
      record = subject.read('2010-02-05')
      expect(record).to eq(['2010-02-05', '1.5'])
    end
  end
end