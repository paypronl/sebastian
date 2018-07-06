class DummyBase < Sebastian::Base
  param :foo
end

class DummyExecuteBase < Sebastian::Base
  param :foo

  def execute
    123
  end
end

class DummyErrorBase < Sebastian::Base
  param :foo

  def execute
    errors.add(:foo)
  end
end

class DummyValidation < Sebastian::Validation
  param :foo

  validates :foo, presence: true
end
