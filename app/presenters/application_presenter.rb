# frozen_string_literal: true

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

  def to_json
    self.to_json(only: self.class::ATTRS, methods:self.class::METHODS)
  end
end