class ChangeBeerStyleToStyleId < ActiveRecord::Migration
  def change
  	change_table :beers do |b|
  		b.rename :style, :style_id
  	end
  end
end
