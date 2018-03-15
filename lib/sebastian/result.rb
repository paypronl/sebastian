# frozen_string_literal: true

module Sebastian
  # Invokes the supplied block and wraps the return value in a Sebastian::Result object.
  #
  # Example:
  #   result = Sebastian::Result.new(value: 'foo')
  #   result.ok?
  #     # => true
  #   result.value
  #     # => 'foo'
  #
  #   result = Sebastian::Result.new(value: 'foo', errors: ['bar'])
  #   result.ok?
  #     # => false
  #   result.value
  #     # => Sebastian::ServiceReturnedErrorsError
  class Result
    attr_reader :errors

    def initialize(value:, errors:)
      @value = value
      @errors = errors
    end

    def ok?
      @errors.empty?
    end

    def value
      return @value if ok?
      raise(
        ResultHasErrorsError,
        'Cannot call value while the service has errors, you should call #ok? first to check'
      )
    end

    def to_s
      if ok?
        "#<Sebastian::Result value: #{@value.inspect}>"
      else
        "#<Sebastian::Result errors: #{@errors.details.inspect}>"
      end
    end

    alias inspect to_s
  end
end
