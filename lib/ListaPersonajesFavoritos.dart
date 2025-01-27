// ignore_for_file: file_names

import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Listapersonajesfavoritos {
  var urls = <String>[];

  Future<void> meterEnLista(String urlAMeter) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //Si al menos se han metido datos en sharedpreferences
    if (prefs.getStringList('favoritos') != null) {
      //Metemos todos los valores de sharedpreferences en la lista
      urls = prefs.getStringList('favoritos')!;
      //Metemos la nueva url
      urls.add(urlAMeter);
      //Print para ver los datos
      if (kDebugMode) {
        print("La lista(después de que se ha añadido datos) es: $urls");
      }
      //Guardamos la lista en sharedpreferences
      saveSetting(urls);
    }
    //Si no hay datos en sharedpreferences
    else {
      //Metemos la nueva url
      urls.add(urlAMeter);
      //Print para ver los datos
      if (kDebugMode) {
        print("La lista(después de que se ha añadido datos) es: $urls");
      }
      //Guardamos la lista en sharedpreferences
      saveSetting(urls);
    }
  }

  Future<void> sacarDeLista(String urlASacar) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //Si al menos se han metido datos en sharedpreferences
    if (prefs.getStringList('favoritos') != null) {
      //Metemos todos los valores de sharedpreferences en la lista
      urls = prefs.getStringList('favoritos')!;
      //Buscamos el url "x" en la lista y lo sacamos
      urls.removeWhere((url) => url == urlASacar);
      if (kDebugMode) {
        print("La lista(después de que se han quitado datos) es: $urls");
      }
      //Guardamos la lista en sharedpreferences
      saveSetting(urls);
    }
    //Si no hay datos en sharedpreferences
    else {
      //Buscamos el url "x" en la lista y lo sacamos
      urls.removeWhere((url) => url == urlASacar);
      if (kDebugMode) {
        print("La lista(después de que se han quitado datos) es: $urls");
      }
      //Guardamos la lista en sharedpreferences
      saveSetting(urls);
    }
  }

//Funcion que guarda la lista de urls(Para luego buscar en la api)
  Future<void> saveSetting(List<String> listaFav) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoritos', listaFav);
    if (kDebugMode) {
      print(
          "Las shared preferences contienen: ${prefs.getStringList('favoritos')}");
    }
  }
}
