class UsuarioModel {
  final String id;
  final String nome;
  final String email;
  final String tipo;

  UsuarioModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.tipo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'tipo': tipo,
    };
  }

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      tipo: map['tipo'],
    );
  }
}