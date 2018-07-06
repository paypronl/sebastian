# frozen_string_literal: true

module Sebastian
  # Provides service functionality. Subclass this to create an service.
  #
  # Example:
  #   class ExampleService < Sebastian::Base
  #     # Required
  #     attr_accessor :foo
  #     attr_accessor :bar
  #
  #     def execute
  #       foo + bar
  #     end
  #   end
  #
  #   result = ExampleService.perform(foo: 10, bar: 5)
  #   if result.ok?
  #     result.value
  #   else
  #     result.errors
  #   end
  class Base
    include ActiveModel::AttributeAssignment
    include ActiveModel::Validations
    extend ActiveModel::Translation

    class << self
      def perform(params = {})
        new(params).perform
      end

      def perform!(params = {})
        new(params).perform!
      end
    end

    def initialize(params = {})
      assign_attributes(params)
    end

    def perform
      Result.new(value: valid? ? execute : nil, errors: errors)
    end

    def perform!
      perform.value!
    end

    protected

    def execute
      raise NotImplementedError, "Must implement #execute in #{self.class} to make the service work"
    end

    def ok?
      errors.empty?
    end
  end
end
