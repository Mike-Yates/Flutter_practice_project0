import 'package:flutter/material.dart';
import './random_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // override the build method that statelesswidget has by default
  @override // this @override is used for readability, not technically required
  Widget build(BuildContext context) {
    // creating a variable. using final means variable can't be reassigned.
    // similar to const. you can assign a listTime.now()
    // const variables can't be changed. like 3.14

    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.black),
        home:
            RandomWords() // custom class that I created. Stored in random_words, which i imported
        );
  }
}
