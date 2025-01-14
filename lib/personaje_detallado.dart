class PersonajeDet {
  final String url;
  final String nombre;
  final String genero;
  final String cultura;
  final String nacimiento;
  final String muerte;
  final List<String> titulos;
  final List<String> motes;
  final String padre;
  final String madre;
  final String conyuge;
  final List<String> alianzas;
  final List<String> libros;
  final List<String> povbooks;
  final List<String> seriestl;
  final List<String> actor;

  const PersonajeDet(
      {required this.url,
      required this.nombre,
      required this.genero,
      required this.cultura,
      required this.nacimiento,
      required this.muerte,
      required this.titulos,
      required this.motes,
      required this.padre,
      required this.madre,
      required this.conyuge,
      required this.alianzas,
      required this.libros,
      required this.povbooks,
      required this.seriestl,
      required this.actor});

  factory PersonajeDet.fromJson(Map<String, dynamic> json) {
    return PersonajeDet(
        url: json['url'],
        nombre: json['name'],
        genero: json['gender'],
        cultura: json['culture'],
        nacimiento: json['born'],
        muerte: json['died'],
        titulos: json['titles'],
        motes: json['aliases'],
        padre: json['father'],
        madre: json['mother'],
        conyuge: json['spouse'],
        alianzas: json['allegiances'],
        libros: json['books'],
        povbooks: json['povBooks'],
        seriestl: json['tvSeries'],
        actor: json['playedBy']);
  }
}
