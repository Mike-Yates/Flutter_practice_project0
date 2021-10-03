import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// WordPair came from our package english_words

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() =>
      RandomWordsState(); // createState() is the fucntion we're overriding
}

class RandomWordsState extends State<RandomWords> {
  // this extends the RandomWords state that I just defined before this
  final _randomWordPairs = <WordPair>[];
  //list of WordPairs (an object defined in english_words package I imported)
  final _savedWordPairs = Set<WordPair>(); // set is a collection of objects where each object can only appear once. this set will store liked wordpairs
  Widget _buildList() {
    return (ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, item) {
        // itemBuilder: (BuildContext context, int index). needs to return ListTile
        if (item.isOdd) return Divider();

        final index = item ~/ 2;
        if (index >= _randomWordPairs.length) {
          _randomWordPairs.addAll(generateWordPairs().take(10));
          //generate word pairs is from the package we imported
        }

        return _buildRow(_randomWordPairs[index]);
        // we need to make a build row function
      },
    ));
  }

  Widget _buildRow(WordPair nextItem) {
    final alreadySaved = _savedWordPairs.contains(nextItem);

    return ListTile(
        title: Text(nextItem.asPascalCase, style: TextStyle(fontSize: 18.0)),
        trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null), //null is no color
        // boolean ? (statements for true) else (statements for false)
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _savedWordPairs.remove(nextItem); // this is where we add or remove words from the list
            } else {
              _savedWordPairs.add(nextItem);
            }
          });
        });
  }

  void _pushSaved() {
    Navigator.of(context).push(// pushing onto the stack
        MaterialPageRoute(
            // has a function called builder. pages are called "routes"
            builder: (BuildContext context) {
      // this is where you put what you want to show on new route
      final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
        return ListTile(
            title: Text(pair.asPascalCase, style: TextStyle(fontSize: 18.0)));
      });

      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
          appBar: AppBar(title: Text('saved wordpairs')),
          body: ListView(children: divided)); // return from builder function
    } // builder
            ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff885566),
          title: Text('Mikes Wordpair Gen'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
          ],
        ),
        body: _buildList());
  }
}
