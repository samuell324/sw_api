import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'secondPage.dart';
import 'characterModel.dart';
import 'package:flutter/foundation.dart';

Future<List<Character>> fetchCharacters(http.Client client) async {
  final response =
  await client.get('http://swapi.dev/api/people/');
  return compute(parseCharacter, response.body);
}

List<Character> parseCharacter(responseBody) {
  final parsed = jsonDecode(responseBody) as Map<String, dynamic>;
  return parsed["results"].map<Character>((json) => Character.fromJson(json)).toList();
}

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
        body: FutureBuilder<List<Character>>(
          future: fetchCharacters(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? CharacterList(character: snapshot.data)
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}


class CharacterList extends StatelessWidget {
  final List<Character> character;
  CharacterList({Key key, this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: character.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Container(
            padding: EdgeInsets.all(15),
            child: ListTile(
              title: Text(
                character[index].name,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => SecondPage(data: character[index].name,)
                ));
              },
            ),
          ),
        );
      },
    );
  }
}