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

//copia y pega de la clase usada en la pantalla de lista de personajes
class ListaPersonajesFavor {
  final List<Personaje> ListaPersonajesFavoritos;

  const ListaPersonajesFavor({
    required this.ListaPersonajesFavoritos,
  });

  factory ListaPersonajesFavor.fromJson(List<dynamic> json) {
    List<Personaje> listadopersonas;
    listadopersonas = json.map((i) => Personaje.fromJson(i)).toList();
    return ListaPersonajesFavor(ListaPersonajesFavoritos: listadopersonas);
  }
}

class _ListaPersFavoritosState extends State<ListaPersFavoritos> {
  final ScrollController _scrollController = ScrollController();
  var Personajes = <String>[];
  var PersonajesURL = <String>[];

  @override
  void initState() {
    crearPers();

    super.initState();
  }

  void crearPers() {
    late Personaje pers;
    void UsarApi() async {
      //revisamos que haya algún personaje en la lista de favoritos(guardada en shared preferences)
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      //si al menos hay algún valor
      if (prefs.getStringList('favoritos') != null) {
        //creamos una lista y la igualamos a lo que haya en el shared preferences
        List<String> PersonajesURL2 = prefs.getStringList('favoritos')!;
        //Un print para revisar valores
        if (kDebugMode) {
          print(PersonajesURL2.toString());
        }
        //por cada personaje en la lista
        for (var UrlDeLista in PersonajesURL2) {
          final url = Uri.parse(UrlDeLista);
          final response = await http.get(url);
          if (response.statusCode == 200) {
            final json = response.body;
            pers = Personaje.fromJson(jsonDecode(json));
            //no hace falta hacer un filtro porque la anterior pantalla(lista de personajes) ya lo ha hecho
            Personajes.add(pers.nombre);
            PersonajesURL.add(pers.url);

            setState(() {}); // Actualiza la Interfaz de Usuario
          }
        }
      }
      //si no se ha añadido nada a la lista
      else {
        if (kDebugMode) {
          print("No has añadido ningún personaje a la lista de favoritos");
        }
      }
    }

    UsarApi();
  }

//Un copia y pega de la función de la pantalla de listas
  void MostrarPersonajeDetalle(String url) {
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
          //el color del appbar es el mismo que el del fondo de pantalla, de la pantalla anterior
          backgroundColor: const Color.fromARGB(255, 130, 183, 209)),
      body: Column(children: [
        Expanded(
            child: ListView.builder(
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
