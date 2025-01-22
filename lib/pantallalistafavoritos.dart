// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:app_juego_de_tronos/pantalla_personaje_detalle.dart';
import 'package:app_juego_de_tronos/personaje.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ListaPersFavoritos extends StatefulWidget {
  const ListaPersFavoritos({super.key});

  @override
  State<ListaPersFavoritos> createState() => _ListaPersFavoritosState();
}

//clase de lista de personas de la api
class ListaPersonajesFavor {
  final List<Personaje> listadelaspersonas;

  const ListaPersonajesFavor({
    required this.listadelaspersonas,
  });

  factory ListaPersonajesFavor.fromJson(List<dynamic> json) {
    List<Personaje> listadopersonas;
    listadopersonas = json.map((i) => Personaje.fromJson(i)).toList();
    return ListaPersonajesFavor(listadelaspersonas: listadopersonas);
  }
}

class _ListaPersFavoritosState extends State<ListaPersFavoritos> {
  final ScrollController _scrollController = ScrollController();
  var Personajes = <String>[];
  var PersonajesURL = <String>[];
  String TextoPers = "";
  //variable para buclar
  //int i = 1;
  @override
  //num personajes total api 2134
  //El numero de paginas maximo es 43
  void initState() {
    crearPers();

    super.initState();
  }

  void mostrarLista() {
    //late PersonajeLista lista;
  }

  //ahora mismo no hace nada, solo el print
  void crearPers() {
    //late int numeropers;
    late Personaje pers;
    void UsarApi() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getStringList('favoritos') != null) {
        List<String> PersonajesURL2 = prefs.getStringList('favoritos')!;
        if (kDebugMode) {
          print(PersonajesURL2.toString());
        }
        for (var UrlDeLista in PersonajesURL2) {
          final url = Uri.parse(UrlDeLista);
          final response = await http.get(url);
          if (response.statusCode == 200) {
            final json = response.body;
            if (kDebugMode) {
              print("textoejemplo$json");
            }
            pers = Personaje.fromJson(jsonDecode(json));

            Personajes.add(pers.nombre);
            PersonajesURL.add(pers.url);

            setState(() {}); // Actualiza la Interfaz de Usuario
          }
        }
      } else {
        if (kDebugMode) {
          print("No has añadido ningún personaje a la lista de favoritos");
        }
      }
    }

    UsarApi();
  }

  void hacerFavorito() {}
  void MostrarPersonajeDetalle(String url) {
    if (kDebugMode) {
      //La url del personaje al que se le haga click es correcta
      print(url);
      //URL_OtraPantalla: url
    }
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return PantallaPersonajeDetalle(url);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 189, 175, 248),
      appBar: AppBar(
          title: const Text("Lista de personajes Favoritos"),
          backgroundColor: const Color.fromARGB(255, 130, 183, 209)),
      body: Column(children: [
        Text(TextoPers,
            style: const TextStyle(fontSize: 30, color: Colors.deepOrange)),
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
