# frozen_string_literal: true

class Oystercard
  attr_reader :balance, :in_journey

  MAX_CARD_BALANCE = 90

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
    @balance -= amount
  end

  def touch_in
    error_message = 'invalid command'
    raise error_message if in_journey == true

    @in_journey = true
  end

  def touch_out
    error_message = 'invalid command'
    raise error_message if in_journey == false

    @in_journey = false
  end
end
