Copy a DB from one host to another
```
db.copyDatabase(<from_db>, <to_db>, <from_hostname>, <username>, <password>);
```

List DBs
```
show dbs
```

Use DB
```
Use <db>
```

List collections
```
show collections
```

List
```
db.movies.find()
```

Run script from terminal:
```
mongo --host HOST DB --quiet script.js
```

Search with regex
```
db.getCollection('collection').find({
    'property':'1',
    'property2': /regex/gi
});
```

Search and echo results by chan
```
db.getCollection('collection').find({
    'property':'1'
}).forEach(function(t){
	print(t.property)
});
```

Search inside arrays
```
db.getCollection('collection').find({
    'property':'1'
	'array':{ "$elemMatch" : {'property':/regex/gi}}
});
```

Export with query
```
mongoexport \
--db DB \
--collection COL \
--query '{"prop": "val"}' \
--pretty \
--out ./out.json
```

Accepts
```
--skip 2				# To skip a number of results
--limit 3 				# Limit the results
--sort "'{_id: 1}'" 	# To sort the result
--pretty				# Beautifier
```


Sources
[quackit](https://www.quackit.com/mongodb/tutorial/)




