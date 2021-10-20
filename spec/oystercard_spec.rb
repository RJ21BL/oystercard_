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
  end

    # describe '#deduct' do
    #   it { is_expected.to respond_to(:deduct).with(1).argument }

    #   it 'balance changes when money is deducted from card' do
    #     expect { subject.deduct 1 }.to change { subject.balance }.by(-1)
    #   end
    # end

  context 'card can touch in and out' do
    describe '#in_journey' do
      it 'is initially not in a journey' do
        expect(subject).not_to be_in_journey
      end
    end

    describe '#touch in' do
      it 'touches user in and puts them in journey' do
        subject.top_up(Oystercard::MAX_CARD_BALANCE)
        subject.touch_in(Oystercard::entry_station)
          expect(subject).to be_in_journey
      end

      it 'will not touch in if below minimum balance' do
        expect{ subject.touch_in(Oystercard::entry_station) }.to raise_error 'Insufficient balance to touch in'
      end

      # it 'touching in changes the default station' do
      # #   subject.touch_in(liverpoolstreet)
      # #   expect(Oystercard::entry_station).to eq liverpoolstreet
      # # end

    end

    describe '#touch out' do
      it 'touches user out and puts them out of journey' do
        subject.top_up(Oystercard::MAX_CARD_BALANCE)
        euston = Oystercard::entry_station
        subject.touch_in(euston)
        subject.touch_out
        expect(subject).not_to be_in_journey
      end

      # it 'deduct from balance on journey completion' do
      #   subject.top_up(Oystercard::MAX_CARD_BALANCE)
      #   subject.touch_in
      #   expect { subject.touch_out }.to change{ subject.balance }.by -Oystercard::MIN_FARE
      # end
    end
  end
end
