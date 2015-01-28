class PriceRange
  attr_reader :low_price, :high_price

  def initialize(low_price, high_price)
    @low_price = low_price
    @high_price = high_price
  end
end

class PriceRangePresenter
  attr_reader :low_price, :high_price

  def initialize(price_range)
    @low_price = init_price(price_range.low_price)
    @high_price = init_price(price_range.high_price)
  end

  def to_s
    Set.new([
      low_price.to_s,
      high_price.to_s
    ]).reject(&:empty?).join(' - ')
  end

  private

  class FixnumPrice
    attr_reader :price

    def initialize(price)
      @price = price
    end

    def to_s
      "$#{price}"
    end
  end

  class NullPrice
    attr_reader :price

    def initialize(price)
      @price = price
    end

    def to_s
      ''
    end
  end
  NilClassPrice = NullPrice

  def init_price(price)
    Object.const_get("PriceRangePresenter::#{price.class}Price").new(price)
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
