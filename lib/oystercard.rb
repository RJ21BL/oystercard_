# frozen_string_literal: true

class Oystercard
  attr_reader :balance, :in_journey

  MAX_CARD_BALANCE = 90
  MIN_CARD_BALANCE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    error_message = 'Maximum balance exceeded'
    raise error_message if amount + balance > MAX_CARD_BALANCE

    @balance += amount
  end

  def deduct(amount)
    # error_message = 'insufficient funds'
    # raise error_message if amount - balance < MIN_CARD_BALANCE

    @balance -= amount
  end

  def touch_in
    error_message = 'Insufficient balance to touch in'
    raise error_message if balance < MIN_CARD_BALANCE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end
end
