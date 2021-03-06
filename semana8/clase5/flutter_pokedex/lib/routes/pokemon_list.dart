import 'package:flutter/material.dart';
import 'package:flutter_pokedex/routes/pokemon_detail.dart';
import 'package:flutter_pokedex/util/http_helper.dart';

class PokemonList extends StatefulWidget {
  int tipo;

  PokemonList(this.tipo);

  @override
  _PokemonListState createState() => _PokemonListState(tipo);
}

class _PokemonListState extends State<PokemonList> {
  HttpHelper helper;
  String imageUrl = "https://pokeres.bastionbot.org/images/pokemon/";
  int tipo;

  _PokemonListState(this.tipo);

  @override
  void initState() {
    helper = HttpHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tipo'),
        ),
        body: FutureBuilder(
          future: helper.getPokemonByType(tipo),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (c, i) {
                    int idPoke =
                        int.parse(snapshot.data[i]['url'].split('/')[6]);
                    return ListTile(
                      leading:
                          Image.network(imageUrl + idPoke.toString() + ".png"),
                      title: Text(snapshot.data[i]['name']),
                      subtitle: Text(idPoke.toString()),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => PokemonDetail(idPoke)));
                      },
                    );
                  });
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            return Text('Cargando');
          },
        ));
  }
}
