import 'dart:convert';

import 'package:app_juego_de_tronos/personaje_detallado.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51

class PantallaPersonajeDetalle extends StatefulWidget {
  String URL_OtraPantalla;
  PantallaPersonajeDetalle(this.URL_OtraPantalla);
  //const PantallaPersonajeDetalle({super.key, required this.URL_OtraPantalla});

  @override
  State<PantallaPersonajeDetalle> createState() =>
      _PantallaPersonajeDetalleState();
}

class _PantallaPersonajeDetalleState extends State<PantallaPersonajeDetalle> {
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
      if (kDebugMode) {
        print(persDet);
      }
      TextoPers =
          "${persDet.nombre} \n ${persDet.genero} \n ${persDet.cultura} \n ${persDet.nacimiento} \n ${persDet.muerte} \n ${persDet.titulos} \n ${persDet.motes} \n ${persDet.padre} \n ${persDet.madre} \n ${persDet.conyuge} \n ${persDet.alianzas} \n ${persDet.libros} \n ${persDet.povbooks} \n ${persDet.seriestl} \n ${persDet.actor}";
    } else {
      TextoPers = "Error al Api";
    }
    if (kDebugMode) {
      print("${persDet.nombre}1");
      print("${persDet.genero}1");
      print("${persDet.cultura}1");
      print("${persDet.nacimiento}1");
      print("${persDet.muerte}1");
      print("${persDet.titulos}1");
      print("${persDet.motes}1");
      print("${persDet.padre}1");
      print("${persDet.madre}1");
      print("${persDet.conyuge}1");
      print("${persDet.alianzas}1");
      print("${persDet.motes}1");
      print("${persDet.libros}1");
      print("${persDet.povbooks}1");
      print("${persDet.seriestl}1");
      print("${persDet.actor}1");
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
