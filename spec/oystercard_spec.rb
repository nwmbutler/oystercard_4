require 'oystercard'

describe Oystercard do
let(:subject) { Oystercard.new }
let(:card) { Oystercard.new(20) }
  it "has a balance" do
  expect(subject.balance).to eq(0)
  end

  it "tops up balance with" do
  expect { subject.top_up(10) }.to change { subject.balance }.by(10)
  end

  it "errors with over limit" do
    expect { subject.top_up(Oystercard::MAX_BALANCE + 1) }.to raise_error "reached max limit"
  end

  it "deducts a fare from card" do
    expect { subject.deduct(10) }.to change { subject.balance }.by(-10)
  end

  it 'should be in journey when touched in' do
    card.touch_in
    expect(card).to be_in_journey
  end

  it 'should then not be in journey' do
    card.touch_in
    card.touch_out
      expect(card).not_to be_in_journey
  end

  it 'raises error if balance too low' do
    expect {subject.touch_in}.to raise_error("insufficient funds")
  end
end
