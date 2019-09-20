import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:indonesia_highlight/domain/model/article.dart';
import 'package:http/http.dart' as http;

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Article> _newsList = new List();

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _newsList.length,
      itemBuilder: (context, index) =>
          Padding(
            padding: EdgeInsets.all(8),
            child: ListItem(_newsList[index]),
          ),
    );
  }

  void getData() async {
    http.Response response = await http.get(
        "https://newsapi.org/v2/top-headlines?country=id&apiKey=833026b00270411c9a3ec23101de1446");
    setState(() {
      _newsList = News
          .fromJson(json.decode(response.body))
          .articles;
    });
  }

}

class ListItem extends StatelessWidget {

  final _biggerFont = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 18.0);
  final Article article;

  ListItem(this.article);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            height: 90,
            width: 120,
            child: Image.network(
              article.urlToImage,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    article.title,
                    style: _biggerFont,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    maxLines: 4,
                  ),
//                  Text(
//                    article.description,
//                    overflow: TextOverflow.ellipsis,
//                    textAlign: TextAlign.left,
//                    maxLines: 2,
//                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
