require_relative 'rate_record'

class Setup
  def init
    db = RateRecord.instance.conn
    db.execute(create_table_stmt)
  end

  def clean
    table_name = RateRecord::TABLE_NAME
    RateRecord.instance.conn.execute("DROP TABLE #{table_name};")
  end

  private

  def create_table_stmt
    table_name = RateRecord::TABLE_NAME
    <<-SQL
      CREATE TABLE IF NOT EXISTS #{table_name} (
        date text NOT NULL PRIMARY KEY,
        rate text
      );
    SQL
  end
end