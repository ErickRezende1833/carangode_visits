import 'dart:convert';
import 'membroFamiliaModel.dart';


class Familia {
  // 1. Identificação do Responsável
  final String nomeTitular;
  final String cpf;
  final String rg;
  final DateTime dataNascimento;
  final String sexo;
  final String estadoCivil;
  final String nomeMae;
  final String nis;

  // 2. Localização e Contacto
  final String comunidade;
  final String pontoReferencia;
  final String telefone;
  final String tipoAcesso;

  // 3. Composição Familiar
  final List<MembroFamiliar> membros;

  // 4. Situação Socioeconómica
  final double rendaMensalBruta;
  final String atividadePrincipal;
  final String dapOuCaf;

  // 5. Diagnóstico da Habitação Atual
  final String tipoConstrucao;
  final String situacaoCobertura;
  final String abastecimentoAgua;
  final String esgotamentoSanitario;
  final bool possuiEnergiaEletrica;

  // 6. Mídia (Caminhos dos ficheiros locais)
  final String? pathFotoFachada;
  final String? pathFotoInterior;
  final String? pathFotoDocumentos;
  final String? pathAssinaturaDigital;

  Familia({
    required this.nomeTitular,
    required this.cpf,
    required this.rg,
    required this.dataNascimento,
    required this.sexo,
    required this.estadoCivil,
    required this.nomeMae,
    required this.nis,
    required this.comunidade,
    required this.pontoReferencia,
    required this.telefone,
    required this.tipoAcesso,
    required this.membros,
    required this.rendaMensalBruta,
    required this.atividadePrincipal,
    required this.dapOuCaf,
    required this.tipoConstrucao,
    required this.situacaoCobertura,
    required this.abastecimentoAgua,
    required this.esgotamentoSanitario,
    required this.possuiEnergiaEletrica,
    this.pathFotoFachada,
    this.pathFotoInterior,
    this.pathFotoDocumentos,
    this.pathAssinaturaDigital,
  });

  // Método copyWith para gerência de estado (Chat mandou fazer "boas práticas")
  Familia copyWith({
    String? nomeTitular,
    String? comunidade,
    String? telefone,
    List<MembroFamiliar>? membros,
    double? rendaMensalBruta,
    String? pathFotoFachada,
    String? pathFotoInterior,
    String? pathFotoDocumentos,
    String? pathAssinaturaDigital,
  }) {
    return Familia(
      nomeTitular: nomeTitular ?? this.nomeTitular,
      cpf: this.cpf,
      rg: this.rg,
      dataNascimento: this.dataNascimento,
      sexo: this.sexo,
      estadoCivil: this.estadoCivil,
      nomeMae: this.nomeMae,
      nis: this.nis,
      comunidade: comunidade ?? this.comunidade,
      pontoReferencia: this.pontoReferencia,
      telefone: telefone ?? this.telefone,
      tipoAcesso: this.tipoAcesso,
      membros: membros ?? this.membros,
      rendaMensalBruta: rendaMensalBruta ?? this.rendaMensalBruta,
      atividadePrincipal: this.atividadePrincipal,
      dapOuCaf: this.dapOuCaf,
      tipoConstrucao: this.tipoConstrucao,
      situacaoCobertura: this.situacaoCobertura,
      abastecimentoAgua: this.abastecimentoAgua,
      esgotamentoSanitario: this.esgotamentoSanitario,
      possuiEnergiaEletrica: this.possuiEnergiaEletrica,
      pathFotoFachada: pathFotoFachada ?? this.pathFotoFachada,
      pathFotoInterior: pathFotoInterior ?? this.pathFotoInterior,
      pathFotoDocumentos: pathFotoDocumentos ?? this.pathFotoDocumentos,
      pathAssinaturaDigital: pathAssinaturaDigital ?? this.pathAssinaturaDigital,
    );
  }

  // Converte para Map para persistência de dados
  Map<String, dynamic> toMap() {
    return {
      'nomeTitular': nomeTitular,
      'cpf': cpf,
      'rg': rg,
      'dataNascimento': dataNascimento.toIso8601String(),
      'sexo': sexo,
      'estadoCivil': estadoCivil,
      'nomeMae': nomeMae,
      'nis': nis,
      'comunidade': comunidade,
      'pontoReferencia': pontoReferencia,
      'telefone': telefone,
      'tipoAcesso': tipoAcesso,
      'membros': jsonEncode(membros.map((x) => x.toMap()).toList()),
      'rendaMensalBruta': rendaMensalBruta,
      'atividadePrincipal': atividadePrincipal,
      'dapOuCaf': dapOuCaf,
      'tipoConstrucao': tipoConstrucao,
      'situacaoCobertura': situacaoCobertura,
      'abastecimentoAgua': abastecimentoAgua,
      'esgotamentoSanitario': esgotamentoSanitario,
      'possuiEnergiaEletrica': possuiEnergiaEletrica ? 1 : 0,
      'pathFotoFachada': pathFotoFachada,
      'pathFotoInterior': pathFotoInterior,
      'pathFotoDocumentos': pathFotoDocumentos,
      'pathAssinaturaDigital': pathAssinaturaDigital,
    };
  }

  // Cria o objeto a partir de um Map
  factory Familia.fromMap(Map<String, dynamic> map) {
    return Familia(
      nomeTitular: map['nomeTitular'] ?? '',
      cpf: map['cpf'] ?? '',
      rg: map['rg'] ?? '',
      dataNascimento: DateTime.parse(map['dataNascimento']),
      sexo: map['sexo'] ?? '',
      estadoCivil: map['estadoCivil'] ?? '',
      nomeMae: map['nomeMae'] ?? '',
      nis: map['nis'] ?? '',
      comunidade: map['comunidade'] ?? '',
      pontoReferencia: map['pontoReferencia'] ?? '',
      telefone: map['telefone'] ?? '',
      tipoAcesso: map['tipoAcesso'] ?? '',
      membros: List<MembroFamiliar>.from(
        jsonDecode(map['membros'] ?? '[]').map((x) => MembroFamiliar.fromMap(x)),
      ),
      rendaMensalBruta: map['rendaMensalBruta']?.toDouble() ?? 0.0,
      atividadePrincipal: map['atividadePrincipal'] ?? '',
      dapOuCaf: map['dapOuCaf'] ?? '',
      tipoConstrucao: map['tipoConstrucao'] ?? '',
      situacaoCobertura: map['situacaoCobertura'] ?? '',
      abastecimentoAgua: map['abastecimentoAgua'] ?? '',
      esgotamentoSanitario: map['esgotamentoSanitario'] ?? '',
      possuiEnergiaEletrica: map['possuiEnergiaEletrica'] == 1,
      pathFotoFachada: map['pathFotoFachada'],
      pathFotoInterior: map['pathFotoInterior'],
      pathFotoDocumentos: map['pathFotoDocumentos'],
      pathAssinaturaDigital: map['pathAssinaturaDigital'],
    );
  }
}