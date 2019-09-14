import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:indonesia_highlight/ih_tabbar.dart' as ihtb;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Indonesia Highlight'),
      ),
      body: _buildMainList(),
      bottomNavigationBar: ihtb.IconTabBar(
          index: 0,
          iconStyle: ihtb.IconStyle(onSelectColor: Colors.red),
          items: [
            ihtb.IconTabBarItem(Icons.home),
            ihtb.IconTabBarItem(Icons.search),
            ihtb.IconTabBarItem(Icons.notifications),
            ihtb.IconTabBarItem(Icons.person),
          ],
      ),
    );
  }

  Widget _buildMainList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}