require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    class_name.constantize
  end

  def table_name
    "#{class_name.to_s.downcase}s"
  end
end

class BelongsToOptions < AssocOptions

  def initialize(name, options = {})
    defaults = {
      class_name: name.to_s.capitalize.singularize,
      foreign_key: "#{name.to_s.singularize.underscore}_id".to_sym,
      primary_key: :id
    }

    defaults.keys.each do |key|
      self.send("#{key}=", options[key] || defaults[key] )
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    defaults = {
      class_name: name.to_s.capitalize.singularize,
      foreign_key: "#{self_class_name.to_s.singularize.underscore}_id".to_sym,
      primary_key: :id
    }

    defaults.keys.each do |key|
      self.send("#{key}=", options[key] || defaults[key])
    end
  end
end

module Associatable
  # Phase IIIb
  # attr_reader :has_many_options, :belongs_to_options

  def belongs_to(name, options = {})
    assoc_options[name] = BelongsToOptions.new(name, options)

    define_method(name) do
      options = self.class.assoc_options[name]
      target = options.model_class
      fkey_value = self.send(options.foreign_key)

      target.where((options.primary_key).to_sym => fkey_value).first
    end
  end

  def has_many(name, options = {})
    assoc_options[name] = HasManyOptions.new(name, self.name, options)

    define_method(name) do
      options = self.class.assoc_options[name]
      target = options.model_class
      pkey_value = self.send(options.primary_key)

      target.where((options.foreign_key).to_sym => pkey_value)
    end
  end

  def assoc_options
    @assoc_options ||= {}
  end
end

class SQLObject
  extend Associatable
end
