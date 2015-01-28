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
