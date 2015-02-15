class BeerStyleIdToStyle < ActiveRecord::Migration
  def change
  	change_table :beers do |b|
  		b.rename :style_id, :style
  	end
  end
end
