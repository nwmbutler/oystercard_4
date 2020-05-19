class Oystercard

MAX_BALANCE = 90
DEFAULT_BALANCE = 0

  attr_reader :balance

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def top_up(value)
   fail "reached max limit" if value + balance > MAX_BALANCE
   @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

end
