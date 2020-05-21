require 'oystercard'

describe Oystercard do
let(:subject) { Oystercard.new }
let(:card) { Oystercard.new(20) }
let(:entry_station) {double :station}
let(:exit_station) {double :exit_station}
let(:journey) { [{ entry_station: entry_station, exit_station: exit_station }] }

  it "has a balance" do
    expect(subject.balance).to eq(0)
  end

  it "tops up balance with" do
    expect { subject.top_up(10) }.to change { subject.balance }.by(10)
  end

  it "errors with over limit" do
    expect { subject.top_up(Oystercard::MAX_BALANCE + 1) }.to raise_error "reached max limit"
  end

  xit "deducts a fare from card" do
    expect { subject.deduct(10) }.to change { subject.balance }.by(-10)
  end

  context 'touches in' do
    before do
      card.touch_in(entry_station)
    end


  it 'should be in journey when touched in' do
    expect(card).to be_in_journey
  end


  it 'should then not be in journey' do
    card.touch_out(exit_station)
    expect(card).not_to be_in_journey
  end

  it "saves the entry station" do
    expect(card.entry_station).to eq entry_station
  end

end

it 'should deduct minimum fare' do
  expect { card.touch_out(exit_station) }.to change { card.balance }.by(-Oystercard::MIN_FARE)
end

  it 'raises error if balance too low' do
    expect {subject.touch_in(entry_station)}.to raise_error("insufficient funds")
  end


  describe '#journey' do

    it 'journey has a default of empty' do
      expect(subject.journey).to be_empty
    end

    it 'stores the entry and exit station' do
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.journey).to eq(journey)
    end
  end
end
