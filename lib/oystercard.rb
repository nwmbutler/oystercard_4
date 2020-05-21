class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journey
  attr_accessor :journey

  MAX_BALANCE = 90
  DEFAULT_BALANCE = 0
  MIN_BALANCE = 1
  MIN_FARE = 1
  DEFAULT_JOURNEY = {}


  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journey = []

  end

  def top_up(value)
   fail "reached max limit" if exceed_max_balance(value)
   @balance += value
  end

  def exceed_max_balance(value)
    value + balance > MAX_BALANCE
  end

  def touch_in(station)
    fail "insufficient funds" unless sufficient_funds?

    @entry_station = station
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @journey << {:entry_station => entry_station, :exit_station => exit_station}
    @entry_station = nil
  end
  # 
  # def in_journey?
  #   !!@entry_station
  # end

  def sufficient_funds?
    @balance > MIN_BALANCE
  end

  def journey
    @journey
  end

private

  def deduct(value)
    @balance -= value
  end
end
