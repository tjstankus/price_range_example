require 'rspec'
require_relative 'price_range'

RSpec.describe PriceRangePresenter do
  subject(:presenter) { described_class.new(price_range) }

  describe 'given low price and high price' do
    let(:price_range) { PriceRange.new(700, 1500) }

    it 'displays price range' do
      expect(subject.to_s).to eq('$700 - $1500')
    end
  end

  describe 'given nil low price' do
    let(:price_range) { PriceRange.new(nil, 1500) }

    it 'only displays high price' do
      expect(subject.to_s).to eq("$1500")
    end
  end

  describe 'given nil high price' do
    let(:price_range) { PriceRange.new(700, nil) }

    it 'only displays low price' do
      expect(subject.to_s).to eq("$700")
    end
  end

  describe 'given equal low price and high price' do
    let(:price_range) { PriceRange.new(700, 700) }

    it 'only displays a single price' do
      expect(subject.to_s).to eq("$700")
    end
  end
end

