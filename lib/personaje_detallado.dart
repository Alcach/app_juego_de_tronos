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
    var Titulos = json['titles'];
    List<String> listaTit = Titulos.cast<String>();
    var Motes = json['aliases'];
    List<String> listaMot = Motes.cast<String>();
    var Alianzas = json['allegiances'];
    List<String> listaAli = Alianzas.cast<String>();
    var Libros = json['books'];
    List<String> listaLibr = Libros.cast<String>();
    var Povbuks = json['povBooks'];
    List<String> LitaPov = Povbuks.cast<String>();
    var SeriesTl = json['tvSeries'];
    List<String> listaTv = SeriesTl.cast<String>();
    var Actores = json['playedBy'];
    List<String> listaActores = Actores.cast<String>();
    return new PersonajeDet(
        url: json['url'],
        nombre: json['name'],
        genero: json['gender'],
        cultura: json['culture'],
        nacimiento: json['born'],
        muerte: json['died'],
        titulos: listaTit,
        motes: listaMot,
        padre: json['father'],
        madre: json['mother'],
        conyuge: json['spouse'],
        alianzas: listaAli,
        libros: listaLibr,
        povbooks: LitaPov,
        seriestl: listaTv,
        actor: listaActores);
  }
}
