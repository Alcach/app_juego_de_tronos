import 'dart:convert';

import 'package:app_juego_de_tronos/personaje_detallado.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51

class PantallaPersonajeDetalle extends StatefulWidget {
  //final String URL;, required this.URL
  const PantallaPersonajeDetalle({super.key});

  @override
  State<PantallaPersonajeDetalle> createState() =>
      _PantallaPersonajeDetalleState();
}

class _PantallaPersonajeDetalleState extends State<PantallaPersonajeDetalle> {
  String textoChiste = "";

  @override
  void initState() {
    UsarApi();
    super.initState();
  }

  String TextoPers = "";
  late int numeropers;
  late PersonajeDet persDet;
  void UsarApi() async {
    final url = Uri.parse("https://anapioficeandfire.com/api/characters/583");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = response.body;
      if (kDebugMode) {
        print(json);
      }
      persDet = PersonajeDet.fromJson(jsonDecode(json));
      TextoPers =
          "${persDet.nombre} \n ${persDet.genero} \n ${persDet.cultura} \n ${persDet.nacimiento} \n ${persDet.muerte} \n ${persDet.titulos} \n ${persDet.motes} \n ${persDet.padre} \n ${persDet.madre} \n ${persDet.conyuge} \n ${persDet.alianzas} \n ${persDet.libros} \n ${persDet.povbooks} \n ${persDet.seriestl} \n ${persDet.actor}";
    } else {
      TextoPers = "Error al Api";
    }
    if (kDebugMode) {
      print(TextoPers);
    }
    setState(() {}); // Actualiza la Interfaz de Usuario
  }

  void hacerFavorito() {
    /*
    if (pers.favorito == false) {
      pers.favorito = true;
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Text(TextoPers,
            style: const TextStyle(fontSize: 30, color: Colors.deepOrange)),
        TextButton(
            onPressed: hacerFavorito,
            child: const Text("Añadir a favoritos(personaje detallado)"))
      ]),
    );
  }
}
