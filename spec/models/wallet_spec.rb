require 'rails_helper'

RSpec.describe Wallet do
  subject { Wallet.new }

  describe '#total_sum' do
    it 'correctly calculates sum in the wallet' do
      subject.coins = { 50 => 2, 10 => 3, 2 => 1 }
      expect(subject.total_sum).to eq(50 * 2 + 10 * 3 + 2)
    end
  end

  describe '#add' do
    it 'correctly adds coins with string keys' do
      expect { subject.add('5' => 1) }.to change { subject.total_sum }.by(5)
    end

    it 'correctly adds coins with integer keys' do
      expect { subject.add(10 => 2) }.to change { subject.total_sum }.by(20)
    end
  end

  describe '#remove' do
    it 'correctly removes coins with string keys' do
      expect { subject.remove('5' => 1) }.to change { subject.total_sum }.by(-5)
    end

    it 'correctly removes coins with integer keys' do
      expect { subject.remove(10 => 2) }.to change { subject.total_sum }.by(-20)
    end
  end

  describe '#change' do
    let(:wallet) { Wallet.new(50 => 1, 25 => 2) }

    it 'correctly calculates all possible enters' do
      [
        {
          wallet: { 50 => 1, 25 => 2, 10 => 2, 2 => 5 },
          change: 104,
          expect: { 50 => 1, 25 => 2, 2 => 2 }
        },
        {
          wallet: { 50 => 1, 25 => 1, 10 => 4 },
          change: 65,
          expect: { 25 => 1, 10 => 4 }
        }
      ].each do |params|
        expect(Wallet.new(params[:wallet]).change(params[:change])).to match(params[:expect])
      end
    end

    it 'returns empty hash if can not give change' do
      expect(wallet.change(1000)).to be_blank
    end

    it 'does not remove coins if it cant change' do
      expect { wallet.change(1000) }.not_to change { wallet.total_sum }
    end

    it 'removes coins if all went well' do
      wallet.change(75)
      expect(wallet.coins).to match(50 => 0, 25 => 1)
    end
  end
end
