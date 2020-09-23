import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'secondPage.dart';

void main() {
  runApp(StarWarsData());
}

class StarWarsData extends StatefulWidget {
  @override
  _StarWarsDataState createState() => _StarWarsDataState();
}

class _StarWarsDataState extends State<StarWarsData> {
  Icon customIcon = Icon(Icons.search);
  static Text titleText = Text("Star Wars API");
  Widget customSearchBar = titleText;

  final String url = "http://swapi.dev/api/people/";
  List data;

  Future<http.Response> getData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["results"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: customSearchBar,
          actions: <Widget>[
            IconButton(
                icon: customIcon,
                onPressed: () {
                  setState(() {
                    if (this.customIcon.icon == Icons.search) {
                      this.customIcon = Icon(Icons.cancel);
                      this.customSearchBar = TextField(
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search character"),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      );
                    } else {
                      this.customIcon = Icon(Icons.search);
                      this.customSearchBar = titleText;
                    }
                  });
                })
          ],
          backgroundColor: Colors.amber,
        ),
        body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Container(
                padding: EdgeInsets.all(15),
                child: ListTile(
                  title: Text(
                    data[index]["name"],
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SecondPage(data: data[index]["name"])
                    ));
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }
}
