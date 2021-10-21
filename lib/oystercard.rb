# frozen_string_literal: true

class Oystercard
  attr_reader :balance, :in_journey, :entry_station

  MAXIMUM_CARD_BALANCE = 90
  MINIMUM_CARD_BALANCE = 1

  def initialize(station = Station.new)
    @balance = 0
    @in_journey = false
    @entry_station = station
  end

  def top_up(amount)
    error_message = 'Maximum balance exceeded'
    raise error_message if amount + balance > MAXIMUM_CARD_BALANCE

    @balance += amount
  end

  def touch_in(station)
    error_message = 'Insufficient balance'
    raise error_message if balance < MINIMUM_CARD_BALANCE

    @in_journey = true
    @entry_station = station.new_station
  end

  def touch_out
    deduct MINIMUM_CARD_BALANCE unless @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
