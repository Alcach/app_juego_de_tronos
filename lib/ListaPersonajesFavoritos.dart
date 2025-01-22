// ignore_for_file: file_names

import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Listapersonajesfavoritos {
  var urls = <String>[];

  Future<void> meterEnLista(String urlAMeter) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('favoritos') != null) {
      urls = prefs.getStringList('favoritos')!;
      urls.add(urlAMeter);
      if (kDebugMode) {
        print("La lista(después de que se ha añadido datos) es: $urls");
      }
      saveSetting(urls);
    } else {
      urls.add(urlAMeter);
      if (kDebugMode) {
        print("La lista(después de que se ha añadido datos) es: $urls");
      }
      saveSetting(urls);
    }
  }

  Future<void> sacarDeLista(String urlASacar) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('favoritos') != null) {
      urls = prefs.getStringList('favoritos')!;
      urls.removeWhere((test) => test == urlASacar);
      if (kDebugMode) {
        print("La lista(después de que se han quitado datos) es: $urls");
      }
      saveSetting(urls);
    } else {
      urls.removeWhere((test) => test == urlASacar);
      if (kDebugMode) {
        print("La lista(después de que se han quitado datos) es: $urls");
      }
      saveSetting(urls);
    }
  }

  Future<void> saveSetting(List<String> listaFav) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoritos', listaFav);
    if (kDebugMode) {
      print(
          "Las shared preferences contienen: ${prefs.getStringList('favoritos')}");
    }
  }
}
