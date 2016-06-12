require 'rails_helper'

RSpec.describe Wallets::GiveChangeInteraction do
  describe '#parse_params' do
    subject { described_class.new }

    it 'return number if it is given' do
      change = 15
      expect(subject.parse_params(change)).to eq(change)
    end

    it 'returns correct sum if banknotes and coins are given' do
      expect(subject.parse_params(banknotes: 2, coins: 15)).to eq(215)
    end
  end
end
