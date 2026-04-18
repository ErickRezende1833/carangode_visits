class Visita {
  final int? id;
  final String nome;
  final bool synced;

  Visita({
    this.id,
    required this.nome,
    this.synced = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'synced': synced ? 1 : 0 ,
    };
  }

  factory Visita.fromMap(Map<String, dynamic> map) {
    return Visita(
      id: map['id'],
      nome: map['nome'],
      synced: map['synced'] == 1,
    );
  }
}