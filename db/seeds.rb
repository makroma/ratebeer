# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

brew1 = Brewery.create name:"Koff", year:1897
brew2 = Brewery.create name:"Malmgard", year:2001
brew3 = Brewery.create name:"Weihenstephaner", year:1042

#b1 = Beer.create name:"Iso 3"
#b2 = Beer.create name:"Karhu"
#b3 = Beer.create name:"Huvila Pale Ale"
#b4 = Beer.create name:"Hefezeizen"
#b5 = Beer.create name:"Helles"
#b6 = Beer.create name:"X Porter"

#brew1.beers << b1
#brew1.beers << b2
#brew1.beers << b3
#brew1.beers << b4
#brew1.beers << b5
#brew1.beers << b6

s1 = Style.create name:"Lager"
s2 = Style.create name:"Pale ale"
s3 = Style.create name:"Porter"
s4 = Style.create name:"Weizen"

#s1.beers << b1
#s1.beers << b2
#s2.beers << b3
#s2.beers << b4



