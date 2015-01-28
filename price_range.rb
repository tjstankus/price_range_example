# TODO: Use null object and remove SimpleDelegator?

class PriceRange
  attr_reader :low_price, :high_price

  def initialize(low_price, high_price)
    @low_price = low_price
    @high_price = high_price
  end
end

require 'delegate'

class PriceRangePresenter < SimpleDelegator
  def to_s
    Set.new([
      formatted_price(low_price),
      formatted_price(high_price)
    ]).reject(&:empty?).join(' - ')
  end

  def formatted_price(price)
    if price
      "$#{price}"
    else
      ''
    end
  end
end

require 'rspec'

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
