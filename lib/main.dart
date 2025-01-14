import 'dart:convert';
import 'dart:math';

import 'package:app_juego_de_tronos/lista_personajes.dart';
import 'package:app_juego_de_tronos/personaje.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Api Juego de tronos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PaginaPrincipal(title: 'Api Juego de tronos'),
    );
  }
}

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key, required this.title});
  final String title;

  @override
  State<PaginaPrincipal> createState() => EstadoInicio();
}

class EstadoInicio extends State<PaginaPrincipal> {
  void AbrirLista() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const ListaPers()));
  }

  String TextoPers = "";
  late int numeropers;

  @override
  void initState() {
    UsarApi();
    super.initState();
  }

  void crearNumRand() {
    //en la api el numero maximo de character es 2134
    numeropers = Random.secure().nextInt(2134) + 1;
  }

  void UsarApi() async {
    crearNumRand();
    final url =
        Uri.parse("https://anapioficeandfire.com/api/characters/$numeropers");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = response.body;
      Personaje pers = Personaje.fromJson(jsonDecode(json));
      //si el personaje sacado no tiene nombre
      if (pers.nombre.isEmpty) {
        crearNumRand();
      }
      TextoPers = "${pers.nombre} \n ${pers.genero}";
    } else {
      TextoPers = "Error al Api";
    }
    setState(() {}); // Actualiza la Interfaz de Usuario
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Text(TextoPers,
            style: const TextStyle(fontSize: 30, color: Colors.deepOrange)),
        TextButton(
            onPressed: AbrirLista, child: const Text("Lista de Personajes"))
      ]),
    );
  }
  /*
  TextoPers.isEmpty
              ? const CircularProgressIndicator()
              :
  */
/*
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Texto de ejemplo:',
            ),
            Text(
              '',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
*/
}
