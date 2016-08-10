require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    @columns ||= DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL
    .first.map! { |el| el.to_sym }
  end

  def self.finalize!
    columns.each do |attribute|
      define_method(attribute.to_s) do
        attributes[attribute]
      end
      define_method("#{attribute.to_s}=") do |val|
        attributes[attribute] = val
      end
    end
  end

  def self.table_name=(default = table_name)
    @table_name = default
  end

  def self.table_name
    # self.to_s.tableize
    "#{self.to_s.downcase}s"
  end

  def self.all
    result = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL
    self.parse_all(result)
  end

  def self.parse_all(results)
    results.map { |result| self.new(result) }
  end

  def self.find(id)
    id_string = id.to_s
    result = DBConnection.execute(<<-SQL, id_string)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        id = ?
    SQL
    result.empty? ? nil : self.new(result[0])
  end

  def initialize(params = {})
    params.each do |attr_name, attr_value|
      sym = attr_name.to_sym
      raise "unknown attribute '#{attr_name}'" unless self.class.columns.include?(sym)
      send("#{attr_name}=".to_sym, attr_value)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map { |col| send(col) }
  end

  def insert
    col_array = self.class.columns.drop(1)
    col_names = col_array.map(&:to_s).join(", ")
    question_marks = (["?"] * col_array.length).join(", ")
    DBConnection.execute(<<-SQL, *attribute_values.drop(1))
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL
    attributes[:id] = DBConnection.last_insert_row_id
  end

  def update
    cols = self.class.columns.drop(1)
    column_equals = cols.map { |col| "#{col.to_s} = ?" }.join(", ")
    DBConnection.execute(<<-SQL, *attribute_values.rotate )
      UPDATE
        #{self.class.table_name}
      SET
        #{column_equals}
      WHERE
        id = ?
    SQL
  end

  def save
    self.id.nil? ? insert : update
  end
end
