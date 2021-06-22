List DBs
```
show dbs
```

Use DB
```js
use <db>
```

List collections
```
show collections
```

List
```js
db.movies.find()
```

Run script from terminal:
```sh
mongo --host HOST DB --quiet script.js
```

Send variables to a script
```sh
mongo \
--host HOST DB \
--eval "var a='1', b='2', c=3" \
--quiet \
script.js
```

Search with regex
```js
db.getCollection('collection').find({
    'property':'1',
    'property2': /regex/gi
});
```

Search and echo results
```js
db.getCollection('collection').find({
    'property':'1'
}).forEach(function(t){
	print(t.property)
});
```

Search inside arrays
```js
db.getCollection('collection').find({
    'property':'1'
	'array':{ "$elemMatch" : {'property':/regex/gi}}
});
```

Empty arrays
```js
db.getCollection('collection').find({'anarray':{$size: 0}})
```

Export with query
```sh
mongoexport \
--db DB \
--collection COL \
--query '{"prop": "val"}' \
--pretty \
--out ./out.json
```

Export with query and sort
```sh
mongoexport \
-d gotweetme \
-c tw_twitz \
-q '{"id": {$numberLong:"422286952"}}' \
--sort '{"date": -1}' \
--jsonArray \
--pretty \
--out output.json
```

Manualy export `script.js`
```js
var cursor = db.getCollection('collection').find({
	'user': NumberLong("422286952")
},{
	'_id':0,
	'field_a':1,
	'field_b':1,
}).sort({'date':-1});

print('[');
while (cursor.hasNext()) {
	// print(tojson(cursor.next()));
	// printjson(cursor.next());
	// printjsononeline(cursor.next());
	var doc = cursor.next();
	doc = JSON.stringify(doc);
	doc = doc.replace( /\{"\$numberLong"\:"([0-9]+)"\}/, '"$1"');
	print(doc+',');
}
print(']');
```

Manualy export command from terminal
```sh
mongo --host HOST DB --quiet script.js > out.json
```

Accepts
```
--skip 2				# To skip a number of results
--limit 3 				# Limit the results
--sort "'{_id: 1}'" 	# To sort the result
--pretty				# Beautifier
```

Update multiple properties inserting an element in an array
```js
db.getCollection('test').update({
	property: 'value',
}, {
	'$push': {
		arrayproperty: 'value'
	}
}, {
	multi: true
});
```

Rename text field/property
```js
db.getCollection('collection').updateMany({}, {$rename: {"field_old": "field_new"}});
```


Copy data of a collection to another collection
```js
var cursor = db.getCollection('old_db').find({}); 
while (cursor.hasNext()) { 
	 var doc = cursor.next();
	 db.getCollection('new_db').insert(doc);
}

```

Get indexes
```js
db.getCollection('collection').getIndexes()
```

Create indexes
```js
// Full text, all properties have to be in the same sentence
db.collection.createIndex({
	'entities.hashtags.text': 'text',
	'full_text': 'text'
});

// Simple index creation
db.collection.createIndex({'user.id': 1});

// Unique Index on a Single Field
db.members.createIndex({"user_id": 1}, {unique: true});

// Unique Compound Index
db.members.createIndex({groupNumber: 1, lastname: 1, firstname: 1}, {unique: true});

// Create a 2dsphere Index
db.collection.createIndex({'field': "2dsphere"});
```

Full text search
```js
// Common
db.stores.find({$text: {$search: "java coffee shop"}})

// Exact
db.stores.find({$text: {$search: "\"coffee shop\""}})

// Exclusion
db.stores.find({$text: {$search: "java shop -coffee"}})


db.stores.find(
	{$text: {$search: "java coffee shop"}},
	{score: {$meta: "textScore"}}
).sort({score: {$meta: "textScore"}})
```

Search within borders
```js
db.getCollection('places').find({
	places: {
		$geoWithin: {
			$geometry: {
				type: "Polygon",
				coordinates:[[
					[-92.2034873007218,14.5113702968473], 
					[-92.2419394491593,14.8567633147243], 
					[-92.1815146444718,15.063735177301], 
					[-92.2529257772843,15.2970004254083], 
					[-91.7585410116593,16.1008071179557], 
					[-90.4896201132218,16.1008071179557], 
					[-90.4676474569718,16.36451565982], 
					[-90.6983603475968,16.4646318580905], 
					[-90.7587851522843,16.7015425356482], 
					[-91.1103476522843,16.8856036313075], 
					[-91.4838828085343,17.2531861730917], 
					[-91.0004843710343,17.2689234735686], 
					[-90.9785117147843,17.829333868902], 
					[-89.1602744100968,17.8241044495994], 
					[-89.1492880819718,17.022218750157], 
					[-89.2206992147843,15.9371313174017], 
					[-88.9625205038468,15.9107194480434], 
					[-88.7263144491593,16.0216259134455], 
					[-88.5065878866593,15.9846639185897], 
					[-88.2154501913468,15.7151640750254], 
					[-88.4351767538468,15.5617594300582], 
					[-88.8746298788468,15.2069057774839], 
					[-89.1547812460343,15.0372115049039], 
					[-89.1822470663468,14.8567633147243], 
					[-89.1383017538468,14.638963503957], 
					[-89.3635214804093,14.410306791358], 
					[-89.5338095663468,14.3358096053901], 
					[-89.4678915975968,14.2027174019691], 
					[-89.7095908163468,14.000267533486], 
					[-89.9457968710343,13.9043077748106], 
					[-90.0886191366593,13.7229420613719], 
					[-90.5500449179093,13.898975507733], 
					[-90.9510458944718,13.8669793279215], 
					[-91.3850058554093,13.9149719403831], 
					[-91.9562949179093,14.2453154573192], 
					[-92.2034873007218,14.5113702968473]
				]]
			}
		}
	}
})
```


Query by distance
```js
db.getCollection('places').find({
	location: {
		$nearSphere: {
			$geometry: {
				type : "Point",
				coordinates: [-90.517724, 14.594525]
			},
			$minDistance: 1000,
			$maxDistance: 10000
		}
	}
})
```

List closer to 1KM
```js
db.getCollection('places').aggregate([{
	$geoNear: {
		near: {
			type: "Point", coordinates: [-90.517724, 14.594525]
		},
		distanceField: "dist.calculated",
		maxDistance: 1000,
		query: { 'imgext': ".jpg" },
		includeLocs: "dist.location",
		spherical: true
	}
}])
```

Cursor length fix
```js
// A simple aggregation with `group`
var cursor = db.getCollection('collection').aggregate([
	{$match: {
		"property": {"$exists": true }
	}},
	{$group: { 
		_id: '$groupable',
		count: {$sum: 1}
	}},
	{$sort: {
		count: -1
	}}
]);

// Converting the "cursor" into an array
var cursor_array = cursor.toArray();

// Looping as an array using `for` instead of `while`
for (var i = 0; i < cursor_array.length; i++) {
	print(cursor_array[i]._id+'\t'+cursor_array[i].count);
}
```

Geospatial Query Operators
* [$geoIntersects](https://docs.mongodb.com/manual/reference/operator/query/geoIntersects/#op._S_geoIntersects)  
* [$geoWithin](https://docs.mongodb.com/manual/reference/operator/query/geoWithin/#op._S_geoWithin)  
* [$near](https://docs.mongodb.com/manual/reference/operator/query/near/#op._S_near)  
* [$nearSphere](https://docs.mongodb.com/manual/reference/operator/query/nearSphere/#op._S_nearSphere)  
* [$geoNear](https://docs.mongodb.com/manual/reference/operator/aggregation/geoNear/#pipe._S_geoNear)  

Copy a DB from one host to another *deprecated*
```js
db.copyDatabase(<from_db>, <to_db>, <from_hostname>, <username>, <password>);
```

## Dump and restore

Dump a collection
```sh
mongodump --out=./ -d database -c collection
```
Dump a database as gziped archive
```sh
mongodump --db=database --gzip --archive=database.archive
```

Restore a collection
```sh
mongorestore -d database -c newcollectionname ./folder/olddatabase.bson
```

Restore a db from archive
```sh
mongorestore --gzip --archive=database.archive
```

https://www.mongodb.com/blog/post/archiving-and-compression-in-mongodb-tools


### Dump and restore examples

Dump collection
```sh
mongodump \
--db=DB \
--out=backup_folder \
--collection=collection
```

Restore a collection to a different DB and different collection name
```sh
mongorestore \
--nsFrom="DB.collection" \
--nsTo="NewDB.NewCollection" \
backup_folder/
```

Dump DB
```sh
mongodump \
--db=DB \
--out=backup_folder
```

Restore DB
```sh
mongorestore \
--nsFrom='DB.*' \
--nsTo='NewDB.*' gotwme/
```

Sources
[quackit](https://www.quackit.com/mongodb/tutorial/)

Install
```sh
brew tap mongodb/brew && brew install mongodb-community@4.2
```

Locations
```sh
# Config
/usr/local/etc/mongod.conf

# Data
/usr/local/var/mongodb
```

Brew message
```
To have launchd start mongodb/brew/mongodb-community now and restart at login:
  brew services start mongodb/brew/mongodb-community
Or, if you don't want/need a background service you can just run:
  mongod --config /usr/local/etc/mongod.conf
```

Services
```sh
brew services start mongodb/brew/mongodb-community
brew services restart mongodb-community
brew services stop mongodb-community
```

Manual stop/start
```sh
launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist
```

Manual run
```sh
cd /usr/local
/usr/local/opt/mongodb/bin/mongod \
--config /usr/local/etc/mongod.conf \
>> /usr/local/var/log/mongodb/output.log \
2>> /usr/local/var/log/mongodb/output.log
```

[macOS Install](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-os-x/)
```sh
brew tap mongodb/brew
brew install mongodb-community@4.4
brew services start mongodb/brew/mongodb-community
```



Check version
```
$mongo
db.version()
```

### $type

| Type                   | Number | Alias                | Notes               |
|:-----------------------|-------:|:---------------------|:--------------------|
|Double                  |       1|"double"              |                     |
|String                  |       2|"string"              |                     |
|Object                  |       3|"object"              |                     |
|Array                   |       4|"array"               |                     |
|Binary data             |       5|"binData"             |                     |
|Undefined               |       6|"undefined"           | Deprecated.         |
|ObjectId                |       7|"objectId"            |                     |
|Boolean                 |       8|"bool"                |                     |
|Date                    |       9|"date"                |                     |
|Null                    |      10|"null"                |                     |
|Regular Expression      |      11|"regex"               |                     |
|DBPointer               |      12|"dbPointer"           | Deprecated.         |
|JavaScript              |      13|"javascript"          |                     |
|Symbol                  |      14|"symbol"              | Deprecated.         |
|JavaScript (with scope) |      15|"javascriptWithScope" |                     |
|32-bit integer          |      16|"int"                 |                     |
|Timestamp               |      17|"timestamp"           |                     |
|64-bit integer          |      18|"long"                |                     |
|Decimal128              |      19|"decimal"             | New in version 3.4. |
|Min key                 |      -1|"minKey"              |                     |
|Max key                 |     127|"maxKey"              |                     |





