import 'package:flutter/foundation.dart';
//import 'dart:convert';

//https://stackoverflow.com/questions/60470918/data-persistence-how-to-persist-list-of-data
class Listapersonajesfavoritos {
  var urls = <String>[];

  void meterEnLista(String urlAMeter) {
    urls.add(urlAMeter);
    if (kDebugMode) {
      print("La lista(a la que se ha añadido datos) es: " + urls.toString());
    }
  }

  void sacarDeLista(String urlASacar) {
    urls.removeWhere((test) => test == urlASacar);
    if (kDebugMode) {
      print("La lista(a la que se han quitado datos) es: " + urls.toString());
    }
  }
  /*
  Future<void> saveSetting(Listapersonajesfavoritos listaFav) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('favoritos', jsonEncode(listaFav.toJson()));
  }
  */
}
