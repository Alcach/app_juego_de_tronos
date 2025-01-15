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
  final ScrollController _scrollController = ScrollController();
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

      TextoPers = "Nombre: " + "${persDet.nombre}";
      CrearTxt();
      //TextoPers ="${persDet.nombre} \n ${persDet.genero} \n ${persDet.cultura} \n ${persDet.nacimiento} \n ${persDet.muerte} \n ${persDet.titulos} \n ${persDet.motes} \n ${persDet.padre} \n ${persDet.madre} \n ${persDet.conyuge} \n ${persDet.alianzas} \n ${persDet.libros} \n ${persDet.povbooks} \n ${persDet.seriestl} \n ${persDet.actor}";
    } else {
      TextoPers = "Error al Api";
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
      backgroundColor: const Color.fromARGB(255, 130, 86, 167),
      body: Column(children: [
        Text(TextoPers,
            style: const TextStyle(
                fontSize: 30, color: Color.fromARGB(255, 110, 66, 53))),
        TextButton(
            onPressed: hacerFavorito,
            child: const Text("Añadir a favoritos(personaje detallado)")),
      ]),
    );
  }
}
