import 'dart:convert';
import 'package:pokemonapp/pokemonData.dart';
import 'package:pokemonapp/utils/PokeHub.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokemon App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  PokeHub pokeHub;
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  @override
  void initState() {
    super.initState();
    _getPokeData();
  }

  Future<String> _getPokeData() async {
    var data = await http.get(url);

    setState(() {
      var pokeData = json.decode(data.body);
      print(pokeData);
      pokeHub = PokeHub.fromJson(pokeData);
      isLoading = false;
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        title: Text('Pokemon App'),
        backgroundColor: Colors.cyan,
      ),
      drawer: Drawer(),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.cyan,
              ),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: pokeHub.pokemon
                  .map((poke) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PokemonData(poke)));
                          },
                          child: Card(
                              child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(poke.img))),
                                ),
                                Text(poke.name,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          )),
                        ),
                      ))
                  .toList(),
            ),
    );
  }
}

/*
https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json
*/
