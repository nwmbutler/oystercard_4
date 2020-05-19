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

end
