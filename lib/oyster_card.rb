class Oystercard

  attr_reader :balance, :station
  attr_writer :in_journey

  DEFAULT_VALUE = 0
  MAXIMUM_VALUE = 90
  MINIMUM_FARE = 1

  def initialize(balance = DEFAULT_VALUE)
    raise "Maximum amount allowed is #{MAXIMUM_VALUE}" if balance > MAXIMUM_VALUE
    @balance = balance
    @in_journey = false
    @station = nil
  end

  def topup(amount)
    raise "Maximum amount allowed is #{MAXIMUM_VALUE}" if @balance + amount > MAXIMUM_VALUE
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in(station)
    raise "Insufficient Funds" if insufficient_balance
    @in_journey = true
    @station = station
  end

  def touch_out
    @in_journey = false
    deduct(MINIMUM_FARE)
  end

  private

  def insufficient_balance
    @balance < MINIMUM_FARE
  end

  def deduct(amount)
    @balance -= amount
  end

end
