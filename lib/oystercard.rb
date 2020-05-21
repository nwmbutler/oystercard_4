require_relative './journey'

class Oystercard
  attr_reader :balance, :exit_station

  MAX_BALANCE = 90
  DEFAULT_BALANCE = 50
  MIN_BALANCE = 1
  MIN_FARE = 1


  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance

  end

  def top_up(value)
   fail "reached max limit" if exceed_max_balance(value)
   @balance += value
  end

  def exceed_max_balance(value)
    value + balance > MAX_BALANCE
  end

  def touch_in(journey, station)
    fail "insufficient funds" unless sufficient_funds?

    journey.journeys << {:entry_station => station, :exit_station => nil}
  end

  def touch_out(journey, exit_station)
    deduct(MIN_FARE)
    if journey.journeys[-1][:exit_station] == nil
      journey.journeys[-1][:exit_station] = exit_station
    else
      journey.journeys << {:entry_station => nil, :exit_station => exit_station}
    end
  end

  def sufficient_funds?
    @balance > MIN_BALANCE
  end

private

  def deduct(value)
    @balance -= value
  end
end
