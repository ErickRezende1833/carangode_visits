import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetalheVisitaView extends StatelessWidget {
  final QueryDocumentSnapshot familia;

  const DetalheVisitaView({
    super.key,
    required this.familia,
  });

  String _formatarData(dynamic timestamp) {
    if (timestamp == null) return 'Não informado';

    if (timestamp is Timestamp) {
      final data = timestamp.toDate();

      return '${data.day.toString().padLeft(2, '0')}/'
          '${data.month.toString().padLeft(2, '0')}/'
          '${data.year}';
    }

    return timestamp.toString();
  }

  String _formatarMoeda(dynamic valor) {
    if (valor == null) return 'Não informado';
    return 'R\$ ${valor.toString()}';
  }

  Widget _infoItem(String label, dynamic valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            valor?.toString().isNotEmpty == true
                ? valor.toString()
                : 'Não informado',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _secao({
    required IconData icon,
    required String titulo,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.blueGrey,
                ),
                const SizedBox(width: 10),
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            ...children,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dados = familia.data() as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Visita'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      child: Icon(
                        Icons.person,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dados['nomeTitular'] ?? 'Sem nome',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            dados['comunidade'] ?? 'Sem comunidade',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            _secao(
              icon: Icons.badge,
              titulo: 'Dados Pessoais',
              children: [
                _infoItem('CPF', dados['cpf']),
                _infoItem('RG', dados['rg']),
                _infoItem('Sexo', dados['sexo']),
                _infoItem('Estado Civil', dados['estadoCivil']),
                _infoItem(
                  'Data de Nascimento',
                  _formatarData(dados['dataNascimento']),
                ),
                _infoItem('Nome da Mãe', dados['nomeMae']),
                _infoItem('NIS', dados['nis']),
                _infoItem('Telefone', dados['telefone']),
              ],
            ),

            _secao(
              icon: Icons.location_on,
              titulo: 'Localização',
              children: [
                _infoItem('Comunidade', dados['comunidade']),
                _infoItem(
                  'Ponto de Referência',
                  dados['pontoReferencia'],
                ),
                _infoItem('Tipo de Acesso', dados['tipoAcesso']),
              ],
            ),

            _secao(
              icon: Icons.attach_money,
              titulo: 'Situação Socioeconômica',
              children: [
                _infoItem(
                  'Renda Mensal Bruta',
                  _formatarMoeda(dados['rendaMensalBruta']),
                ),
                _infoItem(
                  'Atividade Principal',
                  dados['atividadePrincipal'],
                ),
                _infoItem('DAP / CAF', dados['dapOuCaf']),
              ],
            ),

            _secao(
              icon: Icons.home,
              titulo: 'Habitação',
              children: [
                _infoItem(
                  'Tipo de Construção',
                  dados['tipoConstrucao'],
                ),
                _infoItem(
                  'Situação da Cobertura',
                  dados['situacaoCobertura'],
                ),
                _infoItem(
                  'Abastecimento de Água',
                  dados['abastecimentoAgua'],
                ),
                _infoItem(
                  'Esgotamento Sanitário',
                  dados['esgotamentoSanitario'],
                ),
                _infoItem(
                  'Possui Energia Elétrica',
                  dados['possuiEnergiaEletrica'] == true
                      ? 'Sim'
                      : 'Não',
                ),
              ],
            ),

            _secao(
              icon: Icons.calendar_today,
              titulo: 'Registro',
              children: [
                _infoItem(
                  'Data de Cadastro',
                  _formatarData(dados['timestamp']),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}