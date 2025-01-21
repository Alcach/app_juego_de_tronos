import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

//https://stackoverflow.com/questions/60470918/data-persistence-how-to-persist-list-of-data
class Listapersonajesfavoritos {
  var urls = <String>[];

  Future<void> meterEnLista(String urlAMeter) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('favoritos') != null) {
      urls = prefs.getStringList('favoritos')!;
      urls.add(urlAMeter);
      if (kDebugMode) {
        print("La lista(a la que se ha añadido datos) es: " + urls.toString());
      }
      saveSetting(urls);
    } else {
      urls.add(urlAMeter);
      if (kDebugMode) {
        print("La lista(a la que se ha añadido datos) es: " + urls.toString());
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
        print("La lista(a la que se han quitado datos) es: " + urls.toString());
      }
      saveSetting(urls);
    } else {
      urls.removeWhere((test) => test == urlASacar);
      if (kDebugMode) {
        print("La lista(a la que se han quitado datos) es: " + urls.toString());
      }
      saveSetting(urls);
    }
  }

  Future<void> saveSetting(List<String> listaFav) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoritos', listaFav);
    if (kDebugMode) {
      print(prefs.getStringList('favoritos').toString());
    }
  }
}
