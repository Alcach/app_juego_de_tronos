// ignore_for_file: non_constant_identifier_names

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
    //creamos un numero aleatorio
    crearNumRand();
    //hacemos que la url busque al personaje con el numero proporcionado
    final url =
        Uri.parse("https://anapioficeandfire.com/api/characters/$numeropers");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = response.body;
      //transformamos el json del personaje sacado de la api en un objeto "Personaje"
      Personaje pers = Personaje.fromJson(jsonDecode(json));
      //si el personaje sacado no tiene nombre, repetimos la función
      if (pers.nombre.isEmpty) {
        UsarApi();
      }
      //mostramos en pantalla el nombre y género
      TextoPers = "${pers.nombre} \n ${pers.genero}";
    }
    //si la api da error en la búsqueda
    else {
      TextoPers = "Error al Api";
    }
    setState(() {}); // Actualiza la Interfaz de Usuario
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //color de fondo para esta pantalla de la aplicación
      backgroundColor: const Color.fromARGB(255, 130, 183, 209),
      body: Center(
        child: Column(children: [
          //Un texto para poner el nombre y género en la pantalla
          Text(TextoPers,
              style: const TextStyle(fontSize: 30, color: Colors.deepOrange)),
          //Un botón con texto que te lleva a la lista
          TextButton(
              onPressed: AbrirLista, child: const Text("Lista de Personajes"))
        ]),
      ),
    );
  }
}
/*
Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("https://m.media-amazon.com/images/M/MV5BMTNhMDJmNmYtNDQ5OS00ODdlLWE0ZDAtZTgyYTIwNDY3OTU3XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
*/