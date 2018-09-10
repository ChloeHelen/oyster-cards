require 'oyster_card.rb'

describe Oystercard do
  it "is initialized with a balance of 0" do
    card = Oystercard.new
    expect(card.balance).to eq 0
  end
end
