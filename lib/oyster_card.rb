class Oystercard

  attr_reader :balance

  DEFAULT_VALUE = 0
  MAXIMUM_VALUE = 90

  def initialize(balance = DEFAULT_VALUE)
    raise "Maximum amount allowed is #{MAXIMUM_VALUE}" if balance > MAXIMUM_VALUE
    @balance = balance
  end

  def topup(amount)
    raise "Maximum amount allowed is #{MAXIMUM_VALUE}" if @balance + amount > MAXIMUM_VALUE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

end
