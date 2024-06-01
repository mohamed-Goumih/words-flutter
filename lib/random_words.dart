import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  //liste pour stocker les words
  final randomWordsPairs=<WordPair>[];
//Set pour stocker les favoris
  //final savedWords=Set<WordPair>();
  final savedWords=<WordPair>{};

  //Widget pour listView
  Widget buildList(){
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        //itemCount: entries.length,
        itemBuilder: (BuildContext context, int item) {
          if(item.isOdd) return Divider(color:Colors.amber);
          final index=item ~/2;
          if(index>=randomWordsPairs.length){
            randomWordsPairs.addAll(generateWordPairs().take(10));
          }
          return buildRow(randomWordsPairs[index]);
        }
    );
  }
  //Widget ListeTile
  Widget buildRow(WordPair pair){
    final alreadySaved=savedWords.contains(pair);
    return ListTile(
      title:Text(pair.asPascalCase,
        style: TextStyle(fontSize: 18.0),
      ),
      trailing: Icon(alreadySaved?Icons.favorite:Icons.favorite_border,
        color: alreadySaved?Colors.red:null,),
      onTap: (){
        setState(() {
          if(alreadySaved){
            savedWords.remove(pair);
          }
          else{
            savedWords.add(pair);
          }
        });
      },
    );

  }

//fonction pour la navigation
  void pushSaved(){
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (BuildContext context){
              final Iterable<ListTile> tiles=savedWords
                  .map((pair) => ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: TextStyle(fontSize: 18.0),
                ),
              ));
              final List<Widget> divided=ListTile.divideTiles
                (context: context,
                tiles: tiles,).toList();
              return Scaffold(
                appBar: AppBar(
                  title: Text("Mots sauvegardés"),
                ),
                body: ListView(children: divided,),
              );

            }


        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('liste des mots générés'),
          actions: [
            IconButton(
                onPressed: pushSaved,
                icon: Icon(Icons.list))
          ],

        ),
        body: buildList()
    );

  }
}