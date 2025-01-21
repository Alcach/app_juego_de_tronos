import 'dart:convert';
import 'package:app_juego_de_tronos/ListaPersonajesFavoritos.dart';
import 'package:app_juego_de_tronos/personaje_detallado.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51

// ignore: must_be_immutable
class PantallaPersonajeDetalle extends StatefulWidget {
  String URL_OtraPantalla;
  PantallaPersonajeDetalle(this.URL_OtraPantalla);
  //const PantallaPersonajeDetalle({super.key, required this.URL_OtraPantalla});

  @override
  State<PantallaPersonajeDetalle> createState() =>
      _PantallaPersonajeDetalleState();
}

class _PantallaPersonajeDetalleState extends State<PantallaPersonajeDetalle> {
  bool Esfavorito = false;
  //String urlSacadoLista = widget.URL_OtraPantalla;
  @override
  void initState() {
    UsarApi();
    super.initState();
  }

  String TextoPers = "";
  late int numeropers;
  late PersonajeDet persDet;

  void UsarApi() async {
    //https://anapioficeandfire.com/api/characters/583 widget.URL_OtraPantalla
    final url = Uri.parse(widget.URL_OtraPantalla);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = response.body;
      persDet = PersonajeDet.fromJson(jsonDecode(json));
      /*
      if (kDebugMode) {
        print(persDet);
      }
*/
      void CrearTxt() {
        if (persDet.genero.isNotEmpty) {
          TextoPers += "\nGénero: ${persDet.genero}";
        }
        if (persDet.cultura.isNotEmpty) {
          TextoPers += "\nCultura: ${persDet.cultura}";
        }
        if (persDet.nacimiento.isNotEmpty) {
          TextoPers += "\nNacimiento: ${persDet.nacimiento}";
        }
        if (persDet.muerte.isNotEmpty) {
          TextoPers += "\nMuerte: ${persDet.muerte}";
        }
        if (persDet.titulos.isNotEmpty) {
          TextoPers += "\nTítulos: ${persDet.titulos}";
        }
        if (persDet.motes.isNotEmpty) {
          TextoPers += "\nMotes: ${persDet.motes}";
        }
        if (persDet.padre.isNotEmpty) {
          TextoPers += "\nPadre: ${persDet.padre}";
        }
        if (persDet.madre.isNotEmpty) {
          TextoPers += "\nMadre: ${persDet.madre}";
        }
        if (persDet.conyuge.isNotEmpty) {
          TextoPers += "\nCónyuge: ${persDet.conyuge}";
        }
        if (persDet.alianzas.isNotEmpty) {
          TextoPers += "\nAlianzas: ${persDet.alianzas}";
        }
        if (persDet.libros.isNotEmpty) {
          TextoPers += "\nLibros: ${persDet.libros}";
        }
        if (persDet.povbooks.isNotEmpty) {
          TextoPers += "\nPov books: ${persDet.povbooks}";
        }
        if (persDet.seriestl.isNotEmpty) {
          TextoPers += "\nAparición en series: ${persDet.seriestl}";
        }
        if (persDet.actor.isNotEmpty) {
          TextoPers += "\nActor/es: ${persDet.actor}";
        }
      }
      //funcion que dando el nombre y valor haga el texto

      //intentar crear un diccionario
      /*
      //plantilla
      {
        "url": "https://anapioficeandfire.com/api/characters/583",
        "name": "Jon Snow",
        "gender": "Male",
        "culture": "Northmen",
        "born": "In 283 AC",
        "died": "",
        "titles": [
          "Lord Commander of the Night's Watch"
        ],
        "aliases": [
          "Lord Snow",
          "Ned Stark's Bastard",
          "The Snow of Winterfell",
          "The Crow-Come-Over",
          "The 998th Lord Commander of the Night's Watch",
          "The Bastard of Winterfell",
          "The Black Bastard of the Wall",
          "Lord Crow"
        ],
        "father": "",
        "mother": "",
        "spouse": "",
        "allegiances": [
          "https://anapioficeandfire.com/api/houses/362"
        ],
        "books": [
          "https://anapioficeandfire.com/api/books/5"
        ],
        "povBooks": [
          "https://anapioficeandfire.com/api/books/1",
          "https://anapioficeandfire.com/api/books/2",
          "https://anapioficeandfire.com/api/books/3",
          "https://anapioficeandfire.com/api/books/8"
        ],
        "tvSeries": [
          "Season 1",
          "Season 2",
          "Season 3",
          "Season 4",
          "Season 5",
          "Season 6"
        ],
        "playedBy": [
          "Kit Harington"
        ]
      }
      */
      TextoPers = "Nombre: " + "${persDet.nombre}";
      CrearTxt();
      //TextoPers ="${persDet.nombre} \n ${persDet.genero} \n ${persDet.cultura} \n ${persDet.nacimiento} \n ${persDet.muerte} \n ${persDet.titulos} \n ${persDet.motes} \n ${persDet.padre} \n ${persDet.madre} \n ${persDet.conyuge} \n ${persDet.alianzas} \n ${persDet.libros} \n ${persDet.povbooks} \n ${persDet.seriestl} \n ${persDet.actor}";
    } else {
      TextoPers = "Error al Api";
    }
    setState(() {}); // Actualiza la Interfaz de Usuario
  }

  void hacerFavorito() {
    String urlAInsertar = widget.URL_OtraPantalla;
    if (Esfavorito == true) {
      //Lo añade a la lista de favoritos
      Listapersonajesfavoritos().meterEnLista(urlAInsertar);
      //Listapersonajesfavoritos().saveSetting("favoritos",urlAInsertar);
    } else {
      //lo saca de la lista de favoritos
      Listapersonajesfavoritos().sacarDeLista(urlAInsertar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Datos disponibles del personaje"),
          backgroundColor: const Color.fromARGB(255, 98, 160, 155)),
      backgroundColor: const Color.fromARGB(255, 130, 86, 167),
      body: SingleChildScrollView(
          child: Column(children: [
        Text(TextoPers,
            style: const TextStyle(
                fontSize: 30, color: Color.fromARGB(255, 110, 66, 53))),
        TextButton(
            onPressed: hacerFavorito, child: const Text("Añadir a favoritos")),
        Switch(
          value: Esfavorito,
          onChanged: (value) => setState(() {
            Esfavorito = value;
            hacerFavorito();
          }),
        )
      ])),
    );
  }
}
