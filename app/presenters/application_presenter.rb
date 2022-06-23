# frozen_string_literal: true

# Base class for presenters
class ApplicationPresenter < SimpleDelegator
  ATTRS = {}.freeze
  METHODS = {}.freeze
  ASSOCIATIONS = {}.freeze

  def self.collection(objects)
    objects.map do |obj|
      new(obj)
    end
  end

  def self.json_collection(objects)
    objects.to_json(
      only: self::ATTRS,
      methods: self::METHODS,
      include: self::ASSOCIATIONS
    )
  end

  def self.hash_collection(objects)
    JSON.parse(json_collection(objects))
  end

  def klass
    __getobj__.class
  end

  def json(*_args)
    to_json(
      only: self.class::ATTRS,
      methods: self.class::METHODS,
      include: self.class::ASSOCIATIONS
    )
  end
end
