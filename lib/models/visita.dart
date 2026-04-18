class Visita {
  final int? id;
  final String nome;
  final int sincronizado;

  Visita({
    this.id,
    required this.nome,
    this.sincronizado = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'sincronizado': sincronizado,
    };
  }

  factory Visita.fromMap(Map<String, dynamic> map) {
    return Visita(
      id: map['id'],
      nome: map['nome'],
      sincronizado: map['sincronizado'],
    );
  }
}