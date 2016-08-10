require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  # extend BelongsToOptions

  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    # ...
  end

  def table_name

  end
end

class BelongsToOptions < AssocOptions
attr_reader :class_name, :foreign_key, :primary_key

  def initialize(name, options = {})
    if options.empty?
      @class_name = name.capitalize.singularize
      @foreign_key = "#{name.singularize.underscore}_id".to_sym
      @primary_key = :id
    else
      @class_name = options[:class_name]
      @foreign_key = options[:foreign_key]
      @primary_key = options[:primary_key]
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    if options.empty?
      @class_name = name.capitalize.singularize
      @foreign_key = "#{self_class_name.singularize.underscore}_id".to_sym
      @primary_key = :id
    else
      @class_name = options[:class_name]
      @foreign_key = options[:foreign_key]
      @primary_key = options[:primary_key]
    end
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    # ...
  end

  def has_many(name, options = {})
    # ...
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  # Mixin Associatable here...
end
