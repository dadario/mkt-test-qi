# frozen_string_literal: true

class Question < ApplicationRecord
  def options_as_object
    struct = Struct.new(:id, :value)
    options.split(';').map do |option|
      key, value = option.split(':')
      struct.new(key, value)
    end
  end
end
