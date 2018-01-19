require_relative 'lib/rate_importer'
require_relative 'lib/rate_record'
require_relative 'lib/setup'

class Exchanger
  def self.exchange(amount, *dates)
    # result = RateRecord.instance.read(dates.first)
    result = dates.map do |date|
      record = RateRecord.instance.read(date.to_s)
      rate = record ? record.last.to_f : 0.0
      rate * amount
    end
    result = result.first if dates.size == 1
  end

  def self.prepare
    setup  = Setup.new
    setup.clean
    setup.init
    rates = RateImporter.new.import
    p "#{rates.size} rates were imported."
  end
end