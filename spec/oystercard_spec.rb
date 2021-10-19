# frozen_string_literal: true

require 'Oystercard'

describe Oystercard do
  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  context 'can top up and deduct from card' do
    describe '#top_up' do
      it { is_expected.to respond_to(:top_up).with(1).argument }
      it 'balance changes when card is topped up' do
        expect { subject.top_up 10 }.to change {
          subject.balance
        }.by(10)
      end

      it 'raises an error when maximum balance is exceeded' do
        amount = Oystercard::MAX_CARD_BALANCE
        subject.top_up(amount)
        error_message = 'Maximum balance exceeded'
        expect { subject.top_up 1 }.to raise_error error_message
      end
    end

    describe '#deduct' do
      it { is_expected.to respond_to(:deduct).with(1).argument }

      it 'balance changes when money is deducted from card' do
        expect { subject.deduct 1 }.to change { subject.balance }.by(-1)
      end

      # it 'raises error if below minimum balance' do
      #   amount = Oystercard::MIN_CARD_BALANCE
      #   subject.deduct(amount)
      #   error_message = 'insufficient funds'
      #   expect { subject.deduct(100) }.to raise_error error_message
      # end
    end
  end

  context 'card can touch in and out' do
    describe '#touch in' do
      it 'touches user in and puts them in journey' do
        subject.touch_in
        expect(subject.in_journey).to eq true
      end
    end

    describe '#touch out' do
      it 'touches user out and puts them out of journey' do
        subject.touch_in
        subject.touch_out
        expect(subject.in_journey).to eq false
      end
    end
  end

  context 'deduct' do
    describe '#deduct' do
      card = Oystercard.new
      it 'raises error if below minimum balance' do
        card.top_up(89)
        # card.deduct(100)
        error_message = 'insufficient funds'
        expect { card.deduct(100) }.to raise_error error_message
      end
    end
  end
end
