require '../../lib/rate_importer'
require '../../lib/rate_record'
require '../../lib/setup'

describe RateImporter do
  let(:conn) { RateRecord.instance.conn }
  # TODO: it makes sense to move these hooks to some spec_helper, as well as stop using the same db!
  before :all do
    Setup.new.init
  end

  after :all do
    Setup.new.clean
  end

  describe '#import' do
    it 'fills db with data' do
      # TODO: it'd be great to use FakeWeb with 1-3 predefined rates
      subject.import
      record = RateRecord.instance.read('2010-02-02')
      expect(record.first).to eq('2010-02-02')
      expect(record.last.to_f).to be_between(1, 2)
    end
  end
end