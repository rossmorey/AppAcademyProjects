require_relative 'questionsdb'
require 'byebug'

class ModelBase

  def save
    @id ? update : create
  end

  def initialize(options)
  end

  def create_string
    table = "#{self.class.to_s.downcase}s"
    question_marks = ('?'*(self.instance_variables.length - 1)).split('').join(', ')
    <<-DUMMY
      INSERT INTO
        #{table} (#{create_column_string})
      VALUES
        (#{question_marks})
    DUMMY
  end

  def create_column_string
    instance_variables[1..-1].map { |sym| sym.to_s[1..-1] }.join(', ')
  end

  def create_column_values
    values = []
    instance_variables[1..-1].each { |var| values << self.send(var[1..-1].to_sym) }
    values
  end

  def update_string
    table = "#{self.class.to_s.downcase}s"
    question_marks = instance_variables[1..-1].map{ |var| var.to_s[1..-1] + " = ?"}.join(", ")
    <<-DUMMY
      UPDATE
        #{table}
      SET
        #{question_marks}
      WHERE
        id = ?
    DUMMY
  end

  def update_column_values
    values = []
    instance_variables.rotate.each { |var| values << self.send(var[1..-1].to_sym) }
    values
  end

  def create
    QuestionsDatabase.instance.execute(create_string, *create_column_values)
    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    QuestionsDatabase.instance.execute(update_string, *update_column_values)
  end

  def self.find_by_id(id)
    table = "#{self.to_s.downcase}s"
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{table}
      WHERE
        id = ?
    SQL
    # debugger
    self.new(result.first)
  end

  def self.all
  end


end
