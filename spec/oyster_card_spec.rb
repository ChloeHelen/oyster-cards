require 'oyster_card.rb'

describe Oystercard do

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

end
