import 'package:flutter/foundation.dart';

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
}
