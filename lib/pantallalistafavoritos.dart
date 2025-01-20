import 'dart:convert';

import 'package:app_juego_de_tronos/pantalla_personaje_detalle.dart';
import 'package:app_juego_de_tronos/personaje.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListaPersFavoritos extends StatefulWidget {
  var URL_OtraPantalla = <String>[];
  ListaPersFavoritos(this.URL_OtraPantalla);
  //const ListaPersFavoritos({super.key});

  @override
  State<ListaPersFavoritos> createState() => _ListaPersFavoritosState();
}

//clase de lista de personas de la api
class ListaPersonajesFav {
  final List<Personaje> listadelaspersonas;

  const ListaPersonajesFav({
    required this.listadelaspersonas,
  });

  factory ListaPersonajesFav.fromJson(List<dynamic> json) {
    List<Personaje> listadopersonas;
    listadopersonas = json.map((i) => Personaje.fromJson(i)).toList();
    return ListaPersonajesFav(listadelaspersonas: listadopersonas);
  }
}

class _ListaPersFavoritosState extends State<ListaPersFavoritos> {
  final ScrollController _scrollController = ScrollController();
  var Personajes = <String>[];
  var PersonajesURL = <String>[];
  String TextoPers = "";
  //variable para buclar
  //int i = 1;
  int numpagina = 1;
  @override
  //num personajes total api 2134
  //El numero de paginas maximo es 43
  void initState() {
    /*
    do {
      crearPers(i);
    } while (Personajes.length <= 5);
*/

    crearPers();

    super.initState();
  }

  void mostrarLista() {
    //late PersonajeLista lista;
  }

  //ahora mismo no hace nada, solo el print
  void crearPers() {
    //late int numeropers;
    late ListaPersonajesFav superlista;
    late Personaje pers;
    void UsarApi() async {
      final url = Uri.parse(widget.URL_OtraPantalla[1]);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final json = response.body;
        superlista = ListaPersonajesFav.fromJson(jsonDecode(json));
        /*
        if (kDebugMode) {
          print(json);
          print(superlista.listadelaspersonas);
        }
        */
      }
      //el bucle for enseña correctamente los datos
      for (pers in superlista.listadelaspersonas) {
        if (kDebugMode) {
          //el 1 es para ver cuantos van sin nombre
          print("${pers.nombre}1");
        }
        if (pers.nombre.isNotEmpty) {
          Personajes.add(pers.nombre);
          PersonajesURL.add(pers.url);
        }
      }
      /*
      //Esta parte del codigo lo que hacia es coger los personajes del json y si tenian nombre los añadian a la buildlist
      //pers = Personaje.fromJson(superlista.listadelaspersonas);
        
        List<dynamic> parsedListJson = jsonDecode(json);
        List<Personaje> itemsList = List<Personaje>.from(parsedListJson.map<Personaje>((dynamic i) => Personaje.fromJson(i)));
        //pers = Personaje.fromJson(jsonDecode(json));
        //si el personaje sacado no tiene nombre
        return new Personaje(
        nombre: json['name'],
        genero: json['gender'],
        items: itemsList);

        if (pers.nombre.isNotEmpty && Personajes.length <= 5) {
          TextoPers = "${pers.nombre} \n ${pers.genero}";
          Personajes.add(pers.nombre);
        }
      } else {
        TextoPers = "Error al Api";
      }
*/
      setState(() {}); // Actualiza la Interfaz de Usuario
    }

    UsarApi();
  }

  void hacerFavorito() {}
  void MostrarPersonajeDetalle(String url) {
    if (kDebugMode) {
      //La url del personaje al que se le haga click es correcta
      print("$url");
      //URL_OtraPantalla: url
    }
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return new PantallaPersonajeDetalle(url);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 189, 175, 248),
      appBar: AppBar(
          title: Text("Lista de personajes"),
          backgroundColor: const Color.fromARGB(255, 98, 160, 155)),
      body: Column(children: [
        Text(TextoPers,
            style: const TextStyle(fontSize: 30, color: Colors.deepOrange)),
        TextButton(
            onPressed: hacerFavorito,
            child: const Text("Ver Lista favoritos(por hacer)")),
        Expanded(
            child: ListView.builder(
          //Buscar como meter scrollview
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          itemCount: Personajes.length,
          reverse: false,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
                title: TextButton(
                    onPressed: () {
                      MostrarPersonajeDetalle(PersonajesURL[index]);
                    },
                    child: Text(Personajes[index])));
          },
        ))
      ]),
    );
  }
}
