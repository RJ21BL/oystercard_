# frozen_string_literal: true

require 'Oystercard'

describe Oystercard do
  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  context 'can top up to a maxium balance' do
    describe '#top_up' do
      it { is_expected.to respond_to(:top_up).with(1).argument }
      it 'balance changes when card is topped up' do
        expect { subject.top_up 10 }.to change {
          subject.balance
        }.by(10)
      end
      it 'raises an error when maximum balance is exceeded' do
        amount = Oystercard::MAXIMUM_CARD_BALANCE
        subject.top_up(amount)
        error_message = 'Maximum balance exceeded'
        expect { subject.top_up 1 }.to raise_error error_message
      end
    end
  end

  context 'can touch out and in subject to minimum balance' do
    describe '#in_journey' do
      it 'is initially not in a journey' do
        expect(subject).not_to be_in_journey
      end
    end
    describe '#touch in' do
      it 'touches user in and puts them in journey' do
<<<<<<< HEAD
        subject.top_up(Oystercard::MAXIMUM_CARD_BALANCE)
        subject.touch_in
        expect(subject).to be_in_journey
=======
        subject.top_up(Oystercard::MAX_CARD_BALANCE)
        subject.touch_in(Oystercard::entry_station)
          expect(subject).to be_in_journey
>>>>>>> 496e5d9b465eaedef7ae4a08fb4cfd1611c6cade
      end
      it 'will not touch in if below minimum balance' do
<<<<<<< HEAD
        expect{ subject.touch_in }.to raise_error 'Insufficient balance'
=======
        expect{ subject.touch_in(Oystercard::entry_station) }.to raise_error 'Insufficient balance to touch in'
>>>>>>> 496e5d9b465eaedef7ae4a08fb4cfd1611c6cade
      end

      # it 'touching in changes the default station' do
      # #   subject.touch_in(liverpoolstreet)
      # #   expect(Oystercard::entry_station).to eq liverpoolstreet
      # # end

    end
    describe '#touch out' do
      it 'touches user out and puts them out of journey' do
<<<<<<< HEAD
        subject.top_up(Oystercard::MAXIMUM_CARD_BALANCE)
        subject.touch_in
=======
        subject.top_up(Oystercard::MAX_CARD_BALANCE)
        euston = Oystercard::entry_station
        subject.touch_in(euston)
>>>>>>> 496e5d9b465eaedef7ae4a08fb4cfd1611c6cade
        subject.touch_out
        expect(subject).not_to be_in_journey
      end
    end
  end
end
