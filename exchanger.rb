require_relative 'lib/rate_importer'
require_relative 'lib/rate_record'
require_relative 'lib/setup'

class Exchanger
  def self.exchange(amount, dates)
    dates = [dates] unless dates.is_a? Enumerable
    result = (dates.first..dates.last).map do |date|
      record = RateRecord.instance.read(date.to_s)
      rate = record ? record.last.to_f : 0.0
      rate * amount
    end
    dates.size > 1 ? result : result.first
  end

  def self.prepare
    setup = Setup.new
    setup.clean
    setup.init
    rates = RateImporter.new.import
    "#{rates.size} rates were imported."
  end
end