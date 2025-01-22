// ignore_for_file: non_constant_identifier_names, unnecessary_string_interpolations

import 'dart:convert';
import 'package:app_juego_de_tronos/pantalla_personaje_detalle.dart';
import 'package:app_juego_de_tronos/pantallalistafavoritos.dart';
import 'package:app_juego_de_tronos/personaje.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListaPers extends StatefulWidget {
  const ListaPers({super.key});

  @override
  State<ListaPers> createState() => _ListaPersState();
}

//clase de lista de personas de la api
class ListaPersonajes {
  final List<Personaje> Lista;

  const ListaPersonajes({
    required this.Lista,
  });

  factory ListaPersonajes.fromJson(List<dynamic> json) {
    List<Personaje> listadopersonas;
    listadopersonas = json.map((i) => Personaje.fromJson(i)).toList();
    return ListaPersonajes(Lista: listadopersonas);
  }
}

class _ListaPersState extends State<ListaPers> {
  //el scrollcontroller es lo que hace que podamos subir y bajar en la pantalla
  final ScrollController _scrollController = ScrollController();
  var Personajes = <String>[];
  var PersonajesURL = <String>[];

  int numpagina = 1;
  @override
  //num personajes total api 2134
  //El numero de paginas maximo es 43
  void initState() {
    crearPers();
    super.initState();
  }

//cada vez que se muestra la lista, la vacio para que lo ponga en distintas paginas y no uno detrás de otro
  void VaciarLista() {
    Personajes.removeRange(0, Personajes.length);
    PersonajesURL.removeRange(0, PersonajesURL.length);
  }

  void crearPers() {
    late ListaPersonajes listaPers;
    late Personaje pers;
    void UsarApi() async {
      //Usando la documentación de la api, hacemos que la url nos vaya mostrando personajes de 50 en 50
      final url = Uri.parse(
          "https://www.anapioficeandfire.com/api/characters?page=$numpagina&pageSize=50");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final json = response.body;
        //Igualamos nuestra lista al json de 50 personajes
        listaPers = ListaPersonajes.fromJson(jsonDecode(json));
      }
      //Hacemos un bucle para que vaya personaje por personaje
      for (pers in listaPers.Lista) {
        if (kDebugMode) {
          //este es un print para ver en consola los personajes
          //el 1 es para ver cuantos van sin nombre
          print("${pers.nombre}1");
        }
        //si el personaje tiene nombre lo añadimos a las listas
        if (pers.nombre.isNotEmpty) {
          Personajes.add(pers.nombre);
          PersonajesURL.add(pers.url);
        }
      }
      setState(() {}); // Actualiza la Interfaz de Usuario
    }

    UsarApi();
  }

//nos lleva a la lista de favoritos
  void MostrarFavoritos() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return const ListaPersFavoritos();
    }));
  }

//ir a la ultima pagina
  void Ultima() {
    VaciarLista();
    numpagina = 43;
    crearPers();
  }

//ir a la siguiente pagina
  void AvanzarPag() {
    VaciarLista();
    if (numpagina <= 42) {
      numpagina += 1;
      crearPers();
    }
  }

//ir a la primera pagina
  void Primera() {
    VaciarLista();
    numpagina = 1;
    crearPers();
  }

//ir a la anterior pagina
  void RetrocederPag() {
    VaciarLista();
    if (numpagina >= 2) {
      numpagina -= 1;
      crearPers();
    }
  }

//coge la url del personaje de la lista y lo envía a la pantalla del personaje en detalle
  void MostrarPersonajeDetalle(String url) {
    if (kDebugMode) {
      //un print para revisar que sea la url correcta
      print("$url");
    }
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return PantallaPersonajeDetalle(url);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 189, 175, 248),
      appBar: AppBar(
          title: const Text("Lista de personajes"),
          //usamos el fondo de la primera pantalla como el fondo del título
          backgroundColor: const Color.fromARGB(255, 130, 183, 209)),
      body: Column(children: [
        //un botón con texto para vel la lista de favoritos
        TextButton(
            onPressed: MostrarFavoritos,
            child: const Text("Ver Lista favoritos")),
        //Una lista de botones con texto, que muestran los nombres en orden alfabético y que al pulsarlos te llevarán a la pantalla del personaje en detalle
        Expanded(
            child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          itemCount: Personajes.length,
          reverse: false,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
                title: TextButton(
                    onPressed: () {
                      MostrarPersonajeDetalle(PersonajesURL[index]);
                    },
                    child: Text(Personajes[index])));
          },
        )),
        //Botones debajo de la lista que te permiten moverte entre páginas
        Row(mainAxisSize: MainAxisSize.min, children: [
          TextButton(onPressed: Primera, child: const Text("Ir a la primera")),
          TextButton(onPressed: RetrocederPag, child: const Text("Anterior")),
          Text("Numero de página:$numpagina"),
          TextButton(onPressed: AvanzarPag, child: const Text("Siguiente")),
          TextButton(onPressed: Ultima, child: const Text("Ir a la última"))
        ]),
      ]),
    );
  }
}
