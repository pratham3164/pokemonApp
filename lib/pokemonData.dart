import 'package:flutter/material.dart';
import 'package:pokemonapp/utils/PokeHub.dart';

class PokemonData extends StatelessWidget {
  final Pokemon pokedata;
  PokemonData(this.pokedata);

  bodyWidget(BuildContext context) {
    final heigth = MediaQuery.of(context).size.height * 0.1;
    return Stack(
      children: <Widget>[
        Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10,
            top: heigth,
            child: Card(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 100),
                Text(
                  pokedata.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Height: ${pokedata.height}'),
                Text('Weight: ${pokedata.weight}'),
                Text(
                  'Types',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokedata.type
                        .map((T) => FilterChip(
                              label: Text(T),
                              onSelected: (t) {},
                              backgroundColor: Colors.amber,
                            ))
                        .toList()),
                Text(
                  'Weaknesses',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokedata.weaknesses
                        .map((T) => FilterChip(
                              label: Text(T),
                              onSelected: (t) {},
                              backgroundColor: Colors.red,
                            ))
                        .toList()),
                pokedata.nextEvolution != null
                    ? Column(
                        children: <Widget>[
                          Text(
                            'Next Evolution',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: pokedata.nextEvolution
                                  .map((n) => FilterChip(
                                        label: Text(n.name),
                                        onSelected: (t) {},
                                        backgroundColor: Colors.green,
                                      ))
                                  .toList()),
                        ],
                      )
                    :  Text(
                        'Evolution: Max Level',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
              ],
            ))),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(pokedata.img))),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: Text(pokedata.name),
        backgroundColor: Colors.cyan,
        elevation: 0.0,
      ),
      body: bodyWidget(context),
    );
  }
}
