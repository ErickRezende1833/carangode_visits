import 'dart:convert';

class MembroFamiliar {
  final String nome;
  final int idade;
  final String parentesco;

  MembroFamiliar({
    required this.nome,
    required this.idade,
    required this.parentesco,
  });

  // Converte um objeto em Map
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'idade': idade,
      'parentesco': parentesco,
    };
  }

  // Cria um objeto a partir de um Map
  factory MembroFamiliar.fromMap(Map<String, dynamic> map) {
    return MembroFamiliar(
      nome: map['nome'] ?? '',
      idade: map['idade'] ?? 0,
      parentesco: map['parentesco'] ?? '',
    );
  }

  // Método copyWith para gerência de estado (Chat mandou fazer "boas práticas")
  MembroFamiliar copyWith({
    String? nome,
    int? idade,
    String? parentesco,
  }) {
    return MembroFamiliar(
      nome: nome ?? this.nome,
      idade: idade ?? this.idade,
      parentesco: parentesco ?? this.parentesco,
    );
  }
}