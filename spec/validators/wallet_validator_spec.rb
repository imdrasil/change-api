require 'rails_helper'

RSpec.describe WalletValidator do
  subject { described_class.new(attributes: {}) }
  TestModel = Struct.new(:_wallet, :errors)

  describe '#validate?' do
    it 'adds error if record has invalid wallet key' do
      model = TestModel[{ '13' => 1 }, { wallet: [] }]
      subject.validate(model)
      expect(model.errors[:wallet]).to eq(['Not allowed coins'])
    end

    it 'adds error if record has negative coin number' do
      model = TestModel[{ '10' => -1 }, { wallet: [] }]
      subject.validate(model)
      expect(model.errors[:wallet]).to eq(['One of coins has unsuitable state'])
    end

    it 'does not add error if all is well' do
      model = TestModel[{ '10' => 21 }, { wallet: [] }]
      subject.validate(model)
      expect(model.errors[:wallet]).to be_empty
    end
  end
end
