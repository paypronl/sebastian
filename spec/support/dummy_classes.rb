class DummyBase < Sebastian::Base
  attribute :foo
end

class DummyExecuteBase < Sebastian::Base
  attribute :foo

  def execute
    123
  end
end

class DummyErrorBase < Sebastian::Base
  attribute :foo

  def execute
    errors.add(:foo)
  end
end

class DummyValidation < Sebastian::Validation
  attribute :foo

  validates :foo, presence: true
end
