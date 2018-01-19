require 'open-uri'
require 'csv'
require_relative 'rate_record'

class RateImporter
  # URL is taken from http://sdw.ecb.europa.eu/web/generator/docu/SDWHelpExt/downloadingData.html#regularDownloads
  RATES_DATA_URL = 'http://sdw.ecb.europa.eu/quickviewexport.do?SERIES_KEY=EXR.D.USD.EUR.SP00.A&type=csv'

  def import
    rates = fetch_data
    save_rates(rates)
  end

  private

  def save_rates(rates)
    rates_start = find_rates_start(rates)
    rates.slice(rates_start..-1).each do |date, rate|
      RateRecord.instance.create(date, rate)
    end
  end

  def find_rates_start(rates)
    date_format = /\d{4}-\d{2}-\d{2}/
    rates.find_index { |r| (r[0] =~ date_format) == 0 }
  end

  def fetch_data
    rates = open(RATES_DATA_URL).read
    CSV.parse(rates.encode('utf-8'))
  end
end