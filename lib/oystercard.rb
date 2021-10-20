# frozen_string_literal: true

class Oystercard
  attr_reader :balance, :in_journey, :entry_station

  MAXIMUM_CARD_BALANCE = 90
  MINIMUM_CARD_BALANCE = 1

  def initialize
    @balance = 0
    @in_journey = false
    @entry_station = nil
  end

  def top_up(amount)
    error_message = 'Maximum balance exceeded'
    raise error_message if amount + balance > MAXIMUM_CARD_BALANCE

    @balance += amount
  end

<<<<<<< HEAD
  def touch_in
    error_message = 'Insufficient balance'
    raise error_message if balance < MINIMUM_CARD_BALANCE

=======
  def touch_in(station)
    @entry_station = station
    error_message = 'Insufficient balance to touch in'
    raise error_message if balance < MIN_FARE
>>>>>>> 496e5d9b465eaedef7ae4a08fb4cfd1611c6cade
    @in_journey = true
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
