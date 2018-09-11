require 'oyster_card.rb'

describe Oystercard do
  let(:touch_in_station) { double(:station)}
  let(:touch_out_station) { double('touch out station')}

  it { is_expected.to respond_to :in_journey?}
  it { is_expected.to respond_to(:touch_in).with(1).argument}
  it "is initialized with a balance of 0" do
    card = Oystercard.new
    expect(card.balance).to eq 0
  end

  it "cannot be initialized with a balance greater than maximum allowed" do
    expect{Oystercard.new(described_class::MAXIMUM_VALUE + 1)}.to raise_error "Maximum amount allowed is #{described_class::MAXIMUM_VALUE}"
  end

  describe "#topup" do

    it "increases the balance by defined amount" do
      subject.topup(4)
      expect(subject.balance).to eq 4
    end

    it "raises error when balance goes beyond the maximum amount" do
      expect{subject.topup(described_class::MAXIMUM_VALUE + 1)}.to raise_error "Maximum amount allowed is #{described_class::MAXIMUM_VALUE}"
    end

  end

  describe "#touch_in" do

    it "changes in_journey to equal true" do
      subject.topup(10)
      subject.touch_in(touch_in_station)
      expect(subject).to be_in_journey
    end

    it "raise an error when the balance is less than the minimum fare" do
      expect{subject.touch_in(touch_in_station)}.to raise_error "Insufficient Funds"
    end

    it "stores the name of the touch in station" do
      subject.topup(10)
      subject.touch_in(touch_in_station)
      expect(subject.entry_station).to eq touch_in_station
    end

  end

  describe "#touch_out" do

    it "changes in_journey to equal false" do
      subject.topup(10)
      subject.touch_in(touch_in_station)
      subject.touch_out(touch_out_station)
      expect(subject).not_to be_in_journey
    end

    it "reduces the balance by the minimum fare when card touches out" do
      subject.topup(10)
      expect{subject.touch_out(touch_out_station)}.to change{subject.balance}.by(-described_class::MINIMUM_FARE)
    end

    it "stores the name of the touch out station" do
      subject.topup(10)
      subject.touch_in(touch_in_station)
      subject.touch_out(touch_out_station)
      expect(subject.exit_station).to eq touch_out_station
    end

  end

  describe 'journey history' do
    it 'lists all the journeys' do
      subject.topup(10)
      subject.touch_in(touch_in_station)
      subject.touch_out(touch_out_station)
      expect(subject.journey_history).to include({:entry=>touch_in_station, :exit_station=>touch_out_station})
    end
    
  end

end
