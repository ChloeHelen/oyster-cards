require 'station.rb'

describe Station do

subject { described_class.new('bank', 1) }

it { is_expected.to respond_to :station_zone}
it { is_expected.to respond_to :station_name}

end
