class DummyBase < Sebastian::Base
  attr_accessor :foo
end

class DummyExecuteBase < Sebastian::Base
  attr_accessor :foo

  def execute
    123
  end
end

class DummyErrorBase < Sebastian::Base
  attr_accessor :foo

  def execute
    errors.add(:foo)
  end
end
