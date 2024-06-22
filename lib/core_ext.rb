# frozen_string_literal: true

# Monkey patch the Enumerable module to add cleanup
module Enumerable
  def clean
    deep_dup.clean!
  end

  def clean!
    reject! do |item|
      obj = is_a?(Hash) ? self[item] : item

      if obj.respond_to?(:reject!)
        obj.clean!
        obj.blank?
      else
        obj.blank? && !obj.is_a?(FalseClass)
      end
    end

    self
  end
end

# Monkey patch the Array class to get a random entry.
class Array
  def random
    min_by { rand }
  end
end

# Monkey patch the String class to add a conversion to boolean.
class String
  def to_bool
    return true if self == true || self =~ /^([true|ys1])$/i
    return false if self == false || self =~ /^([false|no0])$/i

    raise ArgumentError, "invalid value for Boolean: \"#{self}\""
  end
end

# Monkey patch the TrueClass class to add to_bool and to_human_form methods.
class TrueClass
  def to_bool
    self
  end

  def to_human_form
    'Yes'
  end
end

# Monkey patch the FalseClass class to add to_bool and to_human_form methods.
class FalseClass
  def to_bool
    self
  end

  def to_human_form
    'No'
  end
end

# Monkey patch the NilClass to add the to_bool method.
class NilClass
  def to_bool
    false
  end
end
