require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do

    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    context "general item" do
      let(:subject) {
          [Item.new("general item", 10, 5)]
      }

      it "reduces quality by one" do
        GildedRose.new(subject).update_quality()
        expect(subject[0].quality).to eq 4
      end

      it "reduces quality by one" do
        GildedRose.new(subject).update_quality()
        expect(subject[0].sell_in).to eq 9
      end

      context "when quality is zero" do
        let(:subject) {
          [Item.new("general item", 10, 0)]
        }

        it "doesn't go negative" do
          GildedRose.new(subject).update_quality()
          expect(subject[0].quality).to eq 0
        end
      end

      context "when quality is fifty" do
        let(:subject) {
          [Item.new("general item", 10, 50)]
        }

        it "doesn't go over 50" do
          GildedRose.new(subject).update_quality()
          expect(subject[0].quality).to be <= 50
        end
      end

      context "when sell_in less than zero" do
        let(:subject) {
          [Item.new("general item", 0, 4)]
        }

        it "reduces quality by two" do
          GildedRose.new(subject).update_quality()
          expect(subject[0].quality).to eq 2
        end
      end
    end

    context "Aged Brie Item" do
      let(:subject) {
        [Item.new("Aged Brie", 3, 5)]
      }

      it "increases quality value after update" do
        GildedRose.new(subject).update_quality()
        expect(subject[0].quality).to eq 6
      end
    end

    context "Backstage passes to a TAFKAL80ETC concert Item" do
      context "when sell_in value is 10 or less" do
        let(:subject) {
          [Item.new("Backstage passes to a TAFKAL80ETC concert", 7, 8)]
        }

        it "increases quality by 2" do
          GildedRose.new(subject).update_quality
          expect(subject[0].quality).to eq 10
        end
      end

      context "when sell_in value is 5 or less" do
        let(:subject) {
          [Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 8)]
        }

        it "increases quality by 3" do
          GildedRose.new(subject).update_quality
          expect(subject[0].quality).to eq 11
        end
      end

      context "when sell_in value is less than zero" do
        let(:subject) {
          [Item.new("Backstage passes to a TAFKAL80ETC concert", -2, 8)]
        }

        it "quality value is zero" do
          GildedRose.new(subject).update_quality
          expect(subject[0].quality).to eq 0
        end
      end
    end

    context "Sulfuras, Hand of Ragnaros" do
      let(:subject) {
        [Item.new("Sulfuras, Hand of Ragnaros", 3, 5)]
      }

      it "sell_in value does not decrease" do
        GildedRose.new(subject).update_quality()
        expect(subject[0].sell_in).to eq 3
      end

      it "quality value does not decrease" do
        GildedRose.new(subject).update_quality()
        expect(subject[0].quality).to eq 5
      end
    end
  end
end
