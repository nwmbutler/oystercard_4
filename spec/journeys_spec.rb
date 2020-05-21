require 'journeys'
require 'oystercard'

describe Journeys do
  let(:card) { Oystercard.new(20) }
  let(:station) {double :station}
it "starts a journey" do
  expect(subject).to respond_to :in_journey
end

it 'should be in journey when touched in' do
  card.touch_in(station)
  expect(card.entry_station).not_to be nil
end


end
