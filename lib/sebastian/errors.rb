# frozen_string_literal: true

module Sebastian
  # Top-level error class. All other errors subclass this.
  Error = Class.new(StandardError)

  # Raised if execute is not implemented on subclass.
  NotImplementedError = Class.new(Error)

  # Raised if value is called while there are errors.
  ServiceReturnedErrorsError = Class.new(Error)
end
