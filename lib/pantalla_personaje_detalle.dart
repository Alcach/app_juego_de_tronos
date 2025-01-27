// ignore_for_file: unnecessary_string_interpolations, prefer_adjacent_string_concatenation, non_constant_identifier_names

import 'dart:convert';
import 'package:app_juego_de_tronos/ListaPersonajesFavoritos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class PantallaPersonajeDetalle extends StatefulWidget {
  String URL_OtraPantalla;
  PantallaPersonajeDetalle(this.URL_OtraPantalla, {super.key});

  @override
  State<PantallaPersonajeDetalle> createState() =>
      _PantallaPersonajeDetalleState();
}

class _PantallaPersonajeDetalleState extends State<PantallaPersonajeDetalle> {
  //Un bool para ver si el personaje
  bool Esfavorito = false;
//esta funcion revisará si anteriormente le has dado a que este personaje sea favorito
  void mirarFav() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //si en algun momento has pulsado el botón(aunque luego lo hayas sacado)
    if (prefs.getBool('EsFavorito') != null) {
      //Revisará si el personaje especifico que estas mirando esta en la lista de favoritos
      if (prefs.getStringList('favoritos')!.contains(widget.URL_OtraPantalla)) {
        //si si esta en la lista le asignará el valor correspondiente
        Esfavorito = prefs.getBool('EsFavorito')!;
      }
      //si no esta en la lista se le asigna el valor por defecto false
      else {
        Esfavorito = false;
      }
    }
//un print para ver el valor
    if (kDebugMode) {
      prefs.getBool('EsFavorito');
    }
  }

  @override
  void initState() {
    UsarApi();
    mirarFav();
    super.initState();
  }

  String TextoPers = "";

  void UsarApi() async {
    //declaramos una función que dando el nombre("genero") y valor("Male") haga el texto
    String hazmetxtfunc(String text, dynamic valor) {
      if (valor.isNotEmpty) {
        return "$text: $valor\n";
      } else {
        return "";
      }
    }

    //creamos un map para traducir los nombres de los datos
    Map<String, dynamic> nombresDat = {
      "name": "Nombre",
      "gender": "Género",
      "culture": "Cultura",
      "born": "Nacimiento",
      "died": "Muerte",
      "titles": "Títulos",
      "aliases": "Motes",
      "father": "Padre",
      "mother": "Madre",
      "spouse": "Cónyuge",
      "allegiances": "Alianzas",
      "books": "Libros",
      "povBooks": "Pov books",
      "tvSeries": "Series tv",
      "playedBy": "Actor/es"
    };
    //usamos el url de la lista de personajes
    final url = Uri.parse(widget.URL_OtraPantalla);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = response.body;
      //le asignamos los datos del json a un map
      Map<String, dynamic> DatosPers = jsonDecode(json);
      //declaramos una función que mostrará los datos en la pantalla
      void CrearTxt() {
        //por cada valor en los datos del personaje
        DatosPers.forEach((clave, valor) {
          final traduccion = nombresDat[clave];
          //mirará que no sea nulo y que tenga traducción(así no mostramos la url)
          if (traduccion != null) {
            //Se añade al texto con los datos
            TextoPers += hazmetxtfunc(traduccion, valor);
          }
        });
      }

      CrearTxt();
    } else {
      TextoPers = "Error al Api";
    }
    setState(() {}); // Actualiza la Interfaz de Usuario
  }

//Ponemos el valor del switch en el shared preferences
  Future<void> saveSetting(bool esmifavor) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('EsFavorito', esmifavor);
    if (kDebugMode) {
      print(prefs.getBool('EsFavorito').toString());
    }
  }

//Metemos/sacamos al personaje de la lista de favoritos en función del valor del switch
  void hacerFavoritoSwitch() {
    String urlAInsertar = widget.URL_OtraPantalla;
    if (Esfavorito == true) {
      //Lo añade a la lista de favoritos
      Listapersonajesfavoritos().meterEnLista(urlAInsertar);
      saveSetting(Esfavorito);
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
            //El color de la appbar es igual al fondo de la pantalla, de la pantalla anterior
            backgroundColor: const Color.fromARGB(255, 189, 175, 248)),
        backgroundColor: const Color.fromARGB(255, 84, 86, 180),
        body: Center(
          child: SingleChildScrollView(
              child: Column(children: [
            //texto con la información(disponible) del personaje
            Text(
              TextoPers,
              style: const TextStyle(
                  fontSize: 30, color: Color.fromARGB(255, 224, 164, 34)),
              textAlign: TextAlign.center,
            ),
            //Un texto para que el usuario sepa que hace el switch
            const Text(
              "Añadir a favoritos",
              style: TextStyle(
                  fontSize: 30, color: Color.fromARGB(255, 255, 60, 0)),
            ),
            //el switch para añadir/sacar a la lista de favoritos
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
