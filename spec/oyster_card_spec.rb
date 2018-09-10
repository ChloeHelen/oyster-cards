require 'oyster_card.rb'

describe Oystercard do
  it "is initialized with a balance of 0" do
    card = Oystercard.new
    expect(card.balance).to eq 0
  end

  describe "#topup" do
    it "increases the balance by defined amount" do
      subject.topup(4)
      expect(subject.balance).to eq 4
    end
    
  end

end
