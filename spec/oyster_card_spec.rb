require 'oyster_card.rb'

describe Oystercard do
  it { is_expected.to respond_to :in_journey?}
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

  describe "#deduct" do

    it "reduces the balance by a specified amount" do
      subject.topup(10)
      subject.deduct(10)
      expect(subject.balance).to eq 0
    end

  end

  describe "#touch_in" do

    it "changes in_journey to equal true" do
      subject.topup(10)
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it "raise an error when the balance is less than the minimum fare" do
      expect{subject.touch_in}.to raise_error "Insufficient Funds"
    end

  end

  describe "#touch_out" do

    it "changes in_journey to equal false" do
      subject.topup(10)
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

  end


end
