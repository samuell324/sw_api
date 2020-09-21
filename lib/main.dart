import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() {
  runApp(StarWarsData());
}

class StarWarsData extends StatefulWidget {
  @override
  _StarWarsDataState createState() => _StarWarsDataState();
}

class _StarWarsDataState extends State<StarWarsData> {
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
          title: Text("Star wars characters"),
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
                child: Text(data[index]["name"],
                  style: TextStyle(fontSize: 18, color: Colors.black),
              )),
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
