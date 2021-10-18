require 'Oystercard'

describe Oystercard do 
    it 'has a balance of zero' do 
    expect(subject.balance).to eq 0
    end 

    describe '#top_up' do 
        # one-liner syntax 
        it { is_expected.to respond_to(:top_up).with(1).argument }

        it 'balance changes when card is topped up' do 
            expect{ subject.top_up 10 }.to change{ subject.balance
            }.by 10
        end 

        it 'card has a maximum top-up limit of £90' do 
        expect{ subject.top_up(91) }.to raise_error {'Error, maximum top-up amount is £90'}

        end 
    end 



end 