require 'oyster_card.rb'

describe Oystercard do
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

    # before (:each) do
    #   subject.topup(described_class::MINIMUM_FARE)
    # end

    it "raises error when balance goes beyond the maximum amount" do
      expect{subject.topup(described_class::MAXIMUM_VALUE + 1)}.to raise_error "Maximum amount allowed is #{described_class::MAXIMUM_VALUE}"
    end

  end

  describe "#touch_in" do

    it "changes in_journey to equal true" do
      station = double("Station")
      subject.topup(10)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it "raise an error when the balance is less than the minimum fare" do
      station = double("Station")
      expect{subject.touch_in(station)}.to raise_error "Insufficient Funds"
    end

    it "stores the name of the touch in station" do
      touch_in_station = double("Station")
      subject.topup(10)
      subject.touch_in(touch_in_station)
      expect(subject.station).to eq touch_in_station
    end

  end

  describe "#touch_out" do

    it "changes in_journey to equal false" do
      station = double("Station")
      subject.topup(10)
      subject.touch_in(station)
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it "reduces the balance by the minimum fare when card touches out" do
      subject.topup(10)
      expect{subject.touch_out}.to change{subject.balance}.by(-described_class::MINIMUM_FARE)
    end

  end


end
