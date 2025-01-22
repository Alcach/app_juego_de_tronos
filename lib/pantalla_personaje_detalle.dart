// ignore_for_file: unnecessary_string_interpolations, prefer_adjacent_string_concatenation, non_constant_identifier_names

import 'dart:convert';
import 'package:app_juego_de_tronos/ListaPersonajesFavoritos.dart';
import 'package:app_juego_de_tronos/personaje_detallado.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class PantallaPersonajeDetalle extends StatefulWidget {
  String URL_OtraPantalla;
  PantallaPersonajeDetalle(this.URL_OtraPantalla, {super.key});
  //const PantallaPersonajeDetalle({super.key, required this.URL_OtraPantalla});

  @override
  State<PantallaPersonajeDetalle> createState() =>
      _PantallaPersonajeDetalleState();
}

class _PantallaPersonajeDetalleState extends State<PantallaPersonajeDetalle> {
  bool Esfavorito = false;

  void mirarFav() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('EsFavorito') != null) {
      if (prefs.getStringList('favoritos')!.contains(widget.URL_OtraPantalla)) {
        Esfavorito = prefs.getBool('EsFavorito')!;
      } else {
        Esfavorito = false;
      }
    }

    if (kDebugMode) {
      prefs.getBool('EsFavorito');
    }
  }

  //String urlSacadoLista = widget.URL_OtraPantalla;
  @override
  void initState() {
    UsarApi();
    mirarFav();
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

  Future<void> saveSetting(bool esmifavor) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('EsFavorito', esmifavor);
    if (kDebugMode) {
      print(prefs.getBool('EsFavorito').toString());
    }
  }

  void hacerFavoritoSwitch() {
    String urlAInsertar = widget.URL_OtraPantalla;
    if (Esfavorito == true) {
      //Lo añade a la lista de favoritos
      Listapersonajesfavoritos().meterEnLista(urlAInsertar);
      saveSetting(Esfavorito);
      //Listapersonajesfavoritos().saveSetting("favoritos",urlAInsertar);
    } else {
      //lo saca de la lista de favoritos
      saveSetting(Esfavorito);
      Listapersonajesfavoritos().sacarDeLista(urlAInsertar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Datos disponibles del personaje"),
            backgroundColor: const Color.fromARGB(255, 189, 175, 248)),
        backgroundColor: const Color.fromARGB(255, 84, 86, 180),
        body: Center(
          child: SingleChildScrollView(
              child: Column(children: [
            Text(TextoPers,
                style: const TextStyle(
                    fontSize: 30, color: Color.fromARGB(255, 224, 164, 34))),
            const Text(
              "Añadir a favoritos",
              style: TextStyle(
                  fontSize: 30, color: Color.fromARGB(255, 255, 60, 0)),
            ),
            Switch(
              value: Esfavorito,
              onChanged: (value) => setState(() {
                Esfavorito = value;
                hacerFavoritoSwitch();
              }),
            )
          ])),
        ));
  }
}
