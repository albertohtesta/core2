# frozen_string_literal: true

# Base class for presenters
class ApplicationPresenter < SimpleDelegator
  ATTRS = {}.freeze
  METHODS = {}.freeze

  def self.collection(objects)
    objects.map do |obj|
      new(obj)
    end
  end

  def klass
    __getobj__.class
  end

  def to_json(*_args)
    to_json(only: self.class::ATTRS, methods: self.class::METHODS)
  end
end
