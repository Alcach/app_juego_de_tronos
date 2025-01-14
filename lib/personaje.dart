class Personaje {
  final String url;
  final String nombre;
  final String genero;

  const Personaje(
      {required this.url, required this.nombre, required this.genero});

  factory Personaje.fromJson(Map<String, dynamic> json) {
    return Personaje(
        url: json['url'], nombre: json['name'], genero: json['gender']);
  }
}
