# MongoDB

## Import data

1. Import json data in the database filmographie collection usafer:
```mongo
mongoimport --db filmographie --collection usagers --file path_file
```

## Basic commands
1. show diffrent collections
```mongo
show collections
db.getCollectionNames()
```

2. count the number of document in a collection
```mongo
db.films.find().count()
```

## SEARCH
**db.collection.find(query, projection)**
1. Quelle est l’occupation de Clifford Johnathan ? Ecrivez une requêtes dont la réponse affiche uniquement son nom et son occupation.
```mongo
db.usagers.find({"name":"Clifford Johnathan"}, {"name":1, "occupation":1});
```
2. COMBIEN D'USAGERS ONT ENTRE 18 ET 30 ANS (INCLUS) ?
```mongo
db.usagers.find({$and:[{"age":{$gte:18}}, {"age":{$lte:30}}]}).count()
```
3. Combien d'usagers sont artistes (artist) ou scientifiques (scientist)
```mongo
db.usagers.find({$or:[{"occupation":"artist"}, {"occupation":"scientist"}]}).count()
db.usagers.find({"occupation": {$in:["artist", "scientist"]}}).count()
```
4. Quelles sont les dix femmes auteurs (writer) les plus âgées ?  (Tri par ordre croissant d'age, puis on limite le nombre avec à 10)
```mongo
db.usagers.find({"occupation":"writer", "gender":"F"},{"name":1, "age":1}).sort({"age":-1}).limit(10)
```
5. Quelles sont toutes les occupations présentes dans la base de données ?
```mongo
db.usagers.distinct("occupation");
```

## INSERT
1. Insérer un nouvel utilisateur dans la base de données (vous, par exemple). Ne pas inclure pour l’instant le champ movies.
2.  Choisir un film de la collection movies et mettre à jour l’entrée insérée précédemment en ajoutant le champ movies respectant le schéma adopté par les autres entrées.
```mongo
db.usagers.update({"name" : "Daniel BADIATA"}, {$set:{"movies" : [ { "movieid" : 25, "rating" : 4, "timestamp" : Math.round(new Date().getTime() / 1000)}]}})
```
3. Supprimer le champs movies
```mongo
db.usagers.update({"name" : "Daniel BADIATA"}, {$unset:{movies:""}})
```

## DELETE
1. Supprimer l’entrée de la base de données.
```mongo
db.usagers.remove({"name" : "Daniel BADIATA"})
```
2.  Pour tous les utilisateurs qui ont pour occupation "programmer", changer cette occupation en "developer".
```mongo
db.usagers.update({occupation:"programmer"},{$set:{occupation:"developper"} },{multi:true})
```

## Regex
**
^ : début du fragment de texte,   
.* : n’importe quelle chaine de texte (peut contenir 0 caractère),   
(\d{4}) : quatre chiffres, à garder en mémoire,   
$ : fin du fragment de texte.  
[0-9] : les chiffres de 0 à 9
**
1.  Combien de films sont sortis dans les années quatre-vingt ? (l’année de sortie est indiquée entre parenthèses à la fin du titre de chaque film)
```mongo
db.films.find({"titre":{$regex:"^.*198[0-9]"}}).count()
db.films.find({"titre":/\(198[0-9]\)/}).count()
```
2. Combien de films sont sortis entre 1984 et 1992 ?
```mongo
db.films.find({$or:[{"titre":/\(198[4-9]\)/},{"titre":/\(199[0-2]\)/}]}).count()
```
3. Combien y a-t-il de films d’horreur ("Horror")?
```mongo
db.films.find({"genres":/Horror/}).count()
```
4.  Combien de films ont pour type à la fois "Musical" et "Romance"?
```mongo
db.films.find({$and:[{"genres":/Musical/},{"genres":/Romance/}]}).count()
```

## FOREACH
1.  Comme vous avez pu le constater, stocker l’année de sortie du film dans son titre n’est pas très pratique.
Modifier la collection films en ajoutant à chaque film un champ year contenant l’année et en supprimant cette information du titre.
De nombreuses méthodes peuvent répondre à ce besoin.
```mongo
// delete a field:
db.films.update({}, {$unset:{newGenres:0}}, {multi:true})
// add a field
db.films.update({}, {$set:{"newF":1}})

// extract year
year = doc.title.substring(doc.title.length-5, doc.title.length-1)
doc.title.substring(0, doc.title.length - 7)

db.films.find().forEach(
  fuction(doc){
    db.films.update({_id: doc._id}, {$set:{
      "year": parseInt(doc.title.substring(doc.title.length-5, doc.title.length-1)),
      "title":doc.title.substring(0, doc.title.length-7)
      }})
  }
  );
```
2. Modifier la collection films en remplaçant pour chaque film la valeur du champ genres par un tableau de chaines de caractères.
```mongo
db.films.find().forEach(
  function(doc){
    db.films.update({_id:doc._id}, {$set:{
      genres:doc.genres.split("|")
  }})
  })
```
3.  Modifier la collection usagers en remplaçant pour chaque utilisateur le champ timestamp par un nouveau champ date, de type Date.
```mongo
db.usagers.find().snapshot().forEach(
  function(doc){
    var filmlist = doc.movies;
    filmlist.forEach(function(unfilm){
      unfilm['new_date'] = new Date(unfilm['timestamp']*1000);
    })
    db.usagers.update({_id:doc._id}, doc);
  })

// delete an element in a list
db.usagers.find().snapshot().forEach(function(doc){
  var filmlist = doc.movies;
  filmlist.forEach(function(unfilm){
    delete unfilm['timestamp'];
  })
  db.usagers.update({_id:doc._id},doc);
  })
```

## Use list of mongodb
1. Combien d’utilisateurs ont noté le film qui a pour id 1196 (Star Wars: Episode V - The Empire Strikes Back (1980)) ?
```mongo
db.usagers.find({"movies.movieid":1196}).count()
```
2. Combien d’utilisateurs ont noté tous les films de la première trilogie Star Wars (id 260, 1196, 1210) ?
```mongo
db.usagers.find({$and:[{"movies.movieid":1196}, {"movies.movieid":260}, {"movies.movieid":1210}]}).count()
db.usagers.find({"movies.movieid":{$all:[260,1196,1210]}}).count()
```
3. Combien d’utilisateurs ont notés exactement 48 films ?
```mongo
db.usagers.find({"movies":{$size:48}}).count();
```
4.  Pour chaque utilisateur, créer un champ num_ratings qui indique le nombre de films qu’il a notés.
```mongo
db.usagers.find().snapshot().forEach(function(doc)
  db.usagers.update({_id:doc._id},{
    $set:{"num_ratings":doc.movies.length}
    })
)
```
5. Combien d’utilisateurs ont noté plus de 90 films ?
```mongo
db.usagers.find({"num_ratings":{$gt:90}}).count()
```
6. Combien de notes ont été soumises après le 1er janvier 2001 ?
```mongo
db.usagers.aggregate([
  {$unwind: "$movies"},
  {$match: {"movies.new_date":{$gt: new Date("2001-01-01T00:00:00.000Z")}}},
  {$group:{_id:"", num_note: {$sum:1}}}])
```
7. Quels sont les trois derniers films notés par Jayson Brad ?
```mongo
db.usagers.aggregate([
  {$match:{"name":"Jayson Brad"}},
  {$project: {"name": 1, "movies":1}},
  {$unwind: "$movies"},
  {$sort: {"movies.new_date":-1}},
  {$project : {"name":1,"movies.movieid":1, "movies.new_date":1}},
  {$limit: 3}
  ])
```
8. Obtenez les informations portant uniquement sur Tracy Edward et sa note du film Star Wars: Episode VI - Return of the Jedi, qui a pour id 1210.
```mongo
db.usagers.aggregate([
  {$match:{"name":"Tracy Edward"}},
  {$project:{"name":1, "occupation":1, "age":1, "movies":1}},
  {$unwind: "$movies"},
  {$match:{"movies.movieid":1210}}
  ])
```
9. Combien d’utilisateurs ont donné au film "Untouchables, The" la note de 5.
```mongo
```
10. L’utilisateur Barry Erin vient juste de voir le film Nixon, qui a pour id 14 ; il lui attribue la note de 4.
```mongo
```
11.  L’utilisatrice Marquis Billie n’a en fait pas vu le film "Santa with Muscles", qui a pour id 1311. Supprimer la note entrée par mégarde dans la base de données.
```mongo
```
12.  Les genres du film "Cinderella" devraient être Animation, Children's et Musical. Modifier en une seule requête le document correspondant pour qu’il contienne ces trois genres sans doublon.
```mongo
```
