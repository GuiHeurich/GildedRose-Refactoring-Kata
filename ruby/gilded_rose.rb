class GildedRose

  def initialize(items)
    @items = items
  end

  def update_item()
    @items.each do |item|
      return if item.name == "Sulfuras, Hand of Ragnaros"
      return update_general_item(item) if item.name == "general item"
      return update_backstage_passes(item) if item.name == "Backstage passes to a TAFKAL80ETC concert"
      return update_aged_brie(item) if item.name == "Aged Brie"
    end
  end

  private

  def update_general_item(item)
    item.quality -= 1 unless item.quality.zero?
    item.quality -= 1 if item.sell_in.negative?
    item.sell_in -= 1
  end

  def update_backstage_passes(item)
    return item.quality = 0 if item.sell_in <= 0
    if item.sell_in <= 5
      item.quality += 3
    elsif item.sell_in <= 10
      item.quality += 2
    end
    return item.quality = 50 if item.quality >= 50
  end

  def update_aged_brie(item)
    item.quality += 1 unless item.quality == 50
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
