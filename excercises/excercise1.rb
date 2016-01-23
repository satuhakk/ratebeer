# Huomasin vasta puolimatkassa että komennot piti tallentaa erilliseen tiedostoon - toivottavasti mitään ei jäänyt puuttumaan!

irb(main):005:0> Brewery
=> Brewery(id: integer, name: string, year: integer, created_at: datetime, updated_at: datetime)

irb(main):006:0> doge = Brewery.new name:"BrewDog", year:2007
=> #<Brewery id: nil, name: "BrewDog", year: 2007, created_at: nil, updated_at: nil>

irb(main):007:0> doge
=> #<Brewery id: nil, name: "BrewDog", year: 2007, created_at: nil, updated_at: nil>

irb(main):008:0> doge.save
   (0.2ms)  begin transaction
  SQL (1.5ms)  INSERT INTO "breweries" ("name", "year", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["name", "BrewDog"], ["year", 2007], ["created_at", "2016-01-23 16:27:28.285493"], ["updated_at", "2016-01-23 16:27:28.285493"]]
   (3.8ms)  commit transaction
=> true

irb(main):010:0> Brewery.all
  Brewery Load (0.6ms)  SELECT "breweries".* FROM "breweries"
=> #<ActiveRecord::Relation [#<Brewery id: 1, name: "Koff", year: 1897, created_at: "2016-01-23 13:23:10", updated_at: "2016-01-23 13:23:10">, #<Brewery id: 2, name: "Malmgard", year: 2001, created_at: "2016-01-23 13:23:10", updated_at: "2016-01-23 13:23:10">, #<Brewery id: 3, name: "Weihenstephaner", year: 1042, created_at: "2016-01-23 13:23:10", updated_at: "2016-01-23 13:23:10">, #<Brewery id: 5, name: "BrewDog", year: 2007, created_at: "2016-01-23 16:27:28", updated_at: "2016-01-23 16:27:28">]>

irb(main):011:0> Beer
=> Beer(id: integer, name: string, style: string, brewery_id: integer, created_at: datetime, updated_at: datetime)

irb(main):012:0> b1 = Beer.new name:"Punk IPA", style:"IPA"
=> #<Beer id: nil, name: "Punk IPA", style: "IPA", brewery_id: nil, created_at: nil, updated_at: nil>

irb(main):021:0* doge.beers << b1
   (0.2ms)  begin transaction
  SQL (1.4ms)  INSERT INTO "beers" ("name", "style", "brewery_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["name", "Punk IPA"], ["style", "IPA"], ["brewery_id", 5], ["created_at", "2016-01-23 16:33:18.766845"], ["updated_at", "2016-01-23 16:33:18.766845"]]
   (3.8ms)  commit transaction
  Beer Load (0.5ms)  SELECT "beers".* FROM "beers" WHERE "beers"."brewery_id" = ?  [["brewery_id", 5]]
=> #<ActiveRecord::Associations::CollectionProxy [#<Beer id: 12, name: "Punk IPA", style: "IPA", brewery_id: 5, created_at: "2016-01-23 16:33:18", updated_at: "2016-01-23 16:33:18">]>

irb(main):022:0> doge.beers
=> #<ActiveRecord::Associations::CollectionProxy [#<Beer id: 12, name: "Punk IPA", style: "IPA", brewery_id: 5, created_at: "2016-01-23 16:33:18", updated_at: "2016-01-23 16:33:18">]>

irb(main):023:0> b2 = Beer.new name:"Nanny State", style:"Low alcohol"
=> #<Beer id: nil, name: "Nanny State", style: "Low alcohol", brewery_id: nil, created_at: nil, updated_at: nil>

irb(main):026:0* doge.beers << b2
   (0.2ms)  begin transaction
  SQL (1.4ms)  INSERT INTO "beers" ("name", "style", "brewery_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["name", "Nanny State"], ["style", "Low alcohol"], ["brewery_id", 5], ["created_at", "2016-01-23 16:34:46.036487"], ["updated_at", "2016-01-23 16:34:46.036487"]]
   (4.3ms)  commit transaction
=> #<ActiveRecord::Associations::CollectionProxy [#<Beer id: 12, name: "Punk IPA", style: "IPA", brewery_id: 5, created_at: "2016-01-23 16:33:18", updated_at: "2016-01-23 16:33:18">, #<Beer id: 13, name: "Nanny State", style: "Low alcohol", brewery_id: 5, created_at: "2016-01-23 16:34:46", updated_at: "2016-01-23 16:34:46">]>

irb(main):027:0> r1 = Rating.new score:"40"
=> #<Rating id: nil, score: 40, beer_id: nil, created_at: nil, updated_at: nil>

irb(main):028:0> r2 = Rating.new score:"35"
=> #<Rating id: nil, score: 35, beer_id: nil, created_at: nil, updated_at: nil>

irb(main):029:0> r3 = Rating.new score:"33"
=> #<Rating id: nil, score: 33, beer_id: nil, created_at: nil, updated_at: nil>

irb(main):030:0> b1.ratings << r1
   (0.2ms)  begin transaction
  SQL (1.3ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 40], ["beer_id", 12], ["created_at", "2016-01-23 16:46:47.028233"], ["updated_at", "2016-01-23 16:46:47.028233"]]
   (3.4ms)  commit transaction
  Rating Load (0.5ms)  SELECT "ratings".* FROM "ratings" WHERE "ratings"."beer_id" = ?  [["beer_id", 12]]
=> #<ActiveRecord::Associations::CollectionProxy [#<Rating id: 4, score: 40, beer_id: 12, created_at: "2016-01-23 16:46:47", updated_at: "2016-01-23 16:46:47">]>

irb(main):031:0> b1.ratings << r2
   (0.2ms)  begin transaction
  SQL (1.0ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 35], ["beer_id", 12], ["created_at", "2016-01-23 16:47:46.384493"], ["updated_at", "2016-01-23 16:47:46.384493"]]
   (3.4ms)  commit transaction
=> #<ActiveRecord::Associations::CollectionProxy [#<Rating id: 4, score: 40, beer_id: 12, created_at: "2016-01-23 16:46:47", updated_at: "2016-01-23 16:46:47">, #<Rating id: 5, score: 35, beer_id: 12, created_at: "2016-01-23 16:47:46", updated_at: "2016-01-23 16:47:46">]>

irb(main):032:0> b1.ratings << r3
   (0.2ms)  begin transaction
  SQL (1.3ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 33], ["beer_id", 12], ["created_at", "2016-01-23 16:47:52.710846"], ["updated_at", "2016-01-23 16:47:52.710846"]]
   (3.8ms)  commit transaction
=> #<ActiveRecord::Associations::CollectionProxy [#<Rating id: 4, score: 40, beer_id: 12, created_at: "2016-01-23 16:46:47", updated_at: "2016-01-23 16:46:47">, #<Rating id: 5, score: 35, beer_id: 12, created_at: "2016-01-23 16:47:46", updated_at: "2016-01-23 16:47:46">, #<Rating id: 6, score: 33, beer_id: 12, created_at: "2016-01-23 16:47:52", updated_at: "2016-01-23 16:47:52">]>

irb(main):045:0* b2.ratings.create score:22
   (0.2ms)  begin transaction
  SQL (1.3ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 22], ["beer_id", 13], ["created_at", "2016-01-23 16:51:07.569396"], ["updated_at", "2016-01-23 16:51:07.569396"]]
   (4.5ms)  commit transaction
=> #<Rating id: 7, score: 22, beer_id: 13, created_at: "2016-01-23 16:51:07", updated_at: "2016-01-23 16:51:07">

irb(main):046:0> b2.ratings.create score:40
   (0.2ms)  begin transaction
  SQL (1.3ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 40], ["beer_id", 13], ["created_at", "2016-01-23 16:51:59.172962"], ["updated_at", "2016-01-23 16:51:59.172962"]]
   (4.3ms)  commit transaction
=> #<Rating id: 8, score: 40, beer_id: 13, created_at: "2016-01-23 16:51:59", updated_at: "2016-01-23 16:51:59">

irb(main):047:0> b2.ratings.create score:34
   (0.2ms)  begin transaction
  SQL (1.3ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 34], ["beer_id", 13], ["created_at", "2016-01-23 16:52:11.780026"], ["updated_at", "2016-01-23 16:52:11.780026"]]
   (3.7ms)  commit transaction
=> #<Rating id: 9, score: 34, beer_id: 13, created_at: "2016-01-23 16:52:11", updated_at: "2016-01-23 16:52:11">

irb(main):049:0> Rating.all
  Rating Load (0.6ms)  SELECT "ratings".* FROM "ratings"
=> #<ActiveRecord::Relation [
#<Rating id: 1, score: 10, beer_id: 1, created_at: "2016-01-23 16:24:44", updated_at: "2016-01-23 16:24:44">,
#<Rating id: 2, score: 21, beer_id: 1, created_at: "2016-01-23 16:24:54", updated_at: "2016-01-23 16:24:54">,
#<Rating id: 3, score: 17, beer_id: 1, created_at: "2016-01-23 16:25:05", updated_at: "2016-01-23 16:25:05">,
#<Rating id: 4, score: 40, beer_id: 12, created_at: "2016-01-23 16:46:47", updated_at: "2016-01-23 16:46:47">
 #<Rating id: 5, score: 35, beer_id: 12, created_at: "2016-01-23 16:47:46", updated_at: "2016-01-23 16:47:46">,
 #<Rating id: 6, score: 33, beer_id: 12, created_at: "2016-01-23 16:47:52", updated_at: "2016-01-23 16:47:52">,
 #<Rating id: 7, score: 22, beer_id: 13, created_at: "2016-01-23 16:51:07", updated_at: "2016-01-23 16:51:07">,
 #<Rating id: 8, score: 40, beer_id: 13, created_at: "2016-01-23 16:51:59", updated_at: "2016-01-23 16:51:59">,
 #<Rating id: 9, score: 34, beer_id: 13, created_at: "2016-01-23 16:52:11", updated_at: "2016-01-23 16:52:11">]>
