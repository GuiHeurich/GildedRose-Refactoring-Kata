class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      return if item.name == "Sulfuras, Hand of Ragnaros"

      if item.name == "general item"
        return update_general_item(item)
      end

      if item.name == "Backstage passes to a TAFKAL80ETC concert"
        return update_backstage_passes(item)
      end

      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
      else
        if item.quality < 50
          item.quality = item.quality + 1
        end
      end
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in - 1
      end
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end
    end
  end

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
