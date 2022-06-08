# frozen_string_literal: true

# Base class for repositories
class ApplicationRepository
  class << self
    delegate :all, to: :scope
    delegate :find, to: :scope
    delegate :find_by, to: :scope

    def new_entity(attrs)
      scope.new(attrs)
    end

    def save(model_object)
      model_object.save
    end

    def destroy(model_object)
      model_object.destroy
    end

    def delete(model_object)
      model_object.delete
    end

    protected

    def class_name
      to_s.delete_suffix("Repository")
    end

    def model
      class_name.constantize
    end

    def scope
      model
    end
  end
end
