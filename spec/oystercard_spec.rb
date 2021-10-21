# frozen_string_literal: true

require 'Oystercard'
require 'Station'

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
        subject.top_up(Oystercard::MAXIMUM_CARD_BALANCE)
        station = Station.new
        subject.touch_in(station)
        expect(subject).to be_in_journey
      end
      it 'will not touch in if below minimum balance' do
        station = Station.new
        expect { subject.touch_in(station) }.to raise_error 'Insufficient balance'
      end
    end
    describe '#touch out' do
      it 'touches user out and puts them out of journey' do
        subject.top_up(Oystercard::MAXIMUM_CARD_BALANCE)
        station = Station.new
        subject.touch_in(station)
        subject.touch_out
        expect(subject).not_to be_in_journey
      end
    end
  end

  context 'station' do
    describe 'station' do
      let(:station) { double 'station', new_station: 'new_street' }
      it 'stores the entry station' do
        card = Oystercard.new(station)
        card.top_up(Oystercard::MAXIMUM_CARD_BALANCE)
        expect(card.touch_in(station)).to eq station.new_station
      end
    end
  end
end
