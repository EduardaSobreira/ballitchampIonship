class Time {
  int? id;
  String nome;
  String gritoDeGuerra;
  int anoDeFundacao;
  String? logo;
  int pontos = 0;
  int blots = 0;
  int plifs = 0;
  int advrunghs = 0;

  Time({
    this.id,
    required this.nome,
    required this.gritoDeGuerra,
    required this.anoDeFundacao,
    this.logo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'gritoDeGuerra': gritoDeGuerra,
      'anoDeFundacao': anoDeFundacao,
      'logo': logo,
    };
  }

  static Time fromMap(Map<String, dynamic> map) {
    return Time(
      id: map['id'],
      nome: map['nome'],
      gritoDeGuerra: map['gritoDeGuerra'],
      anoDeFundacao: map['anoDeFundacao'],
      logo: map['logo'],
    );
  }

  void resetarPontos() {
    pontos = 0;
    blots = 0;
    plifs = 0;
    advrunghs = 0;
  }
}
