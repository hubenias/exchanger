require 'singleton'
require 'sqlite3'

class RateRecord
  include Singleton
  DB_FILE = File.expand_path('../../exchanger.db', __FILE__).freeze
  TABLE_NAME = 'rates'.freeze

  def conn
    @conn ||= SQLite3::Database.open DB_FILE
  end

  def read(date)
    query = "SELECT * FROM #{TABLE_NAME} WHERE DATE=?;"
    stmt = conn.prepare query
    stmt.bind_params(date)
    res = stmt.execute
    res.first
  end

  def create(date, rate)
    # puts "commit: #{date}, #{rate}"
    query = "INSERT INTO #{TABLE_NAME} VALUES(?, ?)"
    stmt = conn.prepare query
    stmt.bind_params(date, rate)
    stmt.execute
  end
end
