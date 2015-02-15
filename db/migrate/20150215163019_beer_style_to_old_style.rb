class BeerStyleToOldStyle < ActiveRecord::Migration
  def change
  	change_table :beers do |b|
  		b.rename :style, :oldstyle
  	end
  end
end
