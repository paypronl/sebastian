# frozen_string_literal: true

module Sebastian
  # Provides service functionality. Subclass this to create an service.
  #
  # Example:
  #   class ExampleValidator < Sebastian::Validation
  #     # Required
  #     attr_accessor :foo
  #     attr_accessor :bar
  #
  #     validates :foo, presence: true
  #   end
  #
  #   result = ExampleValidator.perform(foo: 10, bar: 5)
  #   if result.ok?
  #     result.value
  #   else
  #     result.errors
  #   end
  class Validation < Base
    def perform
      Result.new(value: valid?, errors: errors)
    end
  end
end
