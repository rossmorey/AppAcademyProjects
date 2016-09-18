require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    # debugger
    define_method(name) do
      through_options = self.class.assoc_options[through_name]
      target = through_options.model_class
      source_options = target.assoc_options[source_name]

      pkey_value = self.send(through_options.primary_key)

      start_table = self.class.table_name
      through_table = through_options.table_name
      source_table = source_options.table_name

      values = []
      values << "#{through_table}"
      values << "#{source_table}"
      values << "#{source_table}.#{source_table.primary_key} = #{through_table}.#{through_table.foreign_key}"
      values <<  "#{start_table}"
      values << "#{start_table}.#{start_table.primary_key} = #{through_table}.#{through_table.foreign_key}"
      values << "#{start_table}.id = #{pkey_value}"

      results = DBConnection.execute(<<-SQL, *values)
        SELECT
          *
        FROM
          ?
        JOIN ?
          ON ? = ?
        JOIN ?
          ON ? = ?
        WHERE
          ?
      SQL

      results
      # pkey_value = self.send(options.primary_key)
      #
      # target.where((options.foreign_key).to_sym => pkey_value)
    end
  end
end
