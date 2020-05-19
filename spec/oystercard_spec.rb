require 'oystercard'

describe Oystercard do

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

  it { is_expected.to respond_to :touch_in }

  it { is_expected.to respond_to :touch_out }

  it 'should be in journey when touched in' do
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it 'should then not be in journey' do
    subject.touch_in
    subject.touch_out
      expect(subject).not_to be_in_journey
  end

end
