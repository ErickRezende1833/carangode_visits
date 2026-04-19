import 'package:carangode_visits_app/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'widgets.dart';
import '../models/familiaModel.dart';

class FormView extends StatefulWidget {
  const FormView({super.key});

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  // CONTROLADORES
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _rgController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _nomeMaeController = TextEditingController();
  final _nisController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _comunidadeController = TextEditingController();
  final _pontoReferenciaController = TextEditingController();
  final _telefoneController = TextEditingController();

  final _rendaController = TextEditingController();
  final _atividadeController = TextEditingController();
  final _dapController = TextEditingController();

  // Variáveis para os campos de seleção (essenciais para a interface mudar)
  String? _sexo;
  String? _estadoCivil;
  String? _tipoAcesso;
  String? _tipoConstrucao;
  String? _situacaoCobertura;
  String? _abastecimentoAgua;
  String? _esgotamentoSanitario;
  bool _possuiEnergiaEletrica = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _rgController.dispose();
    _dataNascimentoController.dispose();
    _nomeMaeController.dispose();
    _nisController.dispose();
    _comunidadeController.dispose();
    _pontoReferenciaController.dispose();
    _telefoneController.dispose();
    _rendaController.dispose();
    _atividadeController.dispose();
    _dapController.dispose();
    super.dispose();
  }

  // Widget auxiliar para títulos de seção
  Widget _secao(String titulo) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Família'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Identificação do Responsável
              _secao('1. Identificação do Responsável'),
              CustomIconTextField(
                controller: _nomeController,
                labelText: 'Nome do Titular',
                hintText: 'Nome completo',
                prefixIcon: Icons.person,
                validator: (v) => v!.isEmpty ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 16),
              CustomIconTextField(
                controller: _cpfController,
                labelText: 'CPF',
                hintText: '000.000.000-00',
                prefixIcon: Icons.badge,
              ),
              const SizedBox(height: 16),
              CustomIconTextField(
                controller: _rgController,
                labelText: 'RG',
                hintText: 'Número do RG',
                prefixIcon: Icons.perm_identity,
              ),
              const SizedBox(height: 16),
              CustomIconTextField(
                controller: _dataNascimentoController,
                labelText: 'Data de Nascimento',
                hintText: 'DD/MM/AAAA',
                prefixIcon: Icons.calendar_today,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Sexo',
                  prefixIcon: Icon(Icons.wc),
                  border: OutlineInputBorder(),
                ),
                value: _sexo,
                items: ['Feminino', 'Masculino']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) => setState(() => _sexo = val),
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Estado Civil',
                  prefixIcon: Icon(Icons.favorite),
                  border: OutlineInputBorder(),
                ),
                value: _estadoCivil,
                items: ['Solteiro(a)', 'Casado(a)', 'Divorciado(a)', 'Viúvo(a)']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) => setState(() => _estadoCivil = val),
              ),
              const SizedBox(height: 16),
              CustomIconTextField(
                controller: _nomeMaeController,
                labelText: 'Nome da Mãe',
                hintText: 'Nome completo da mãe',
                prefixIcon: Icons.pregnant_woman,
              ),
              const SizedBox(height: 16),
              CustomIconTextField(
                controller: _nisController,
                labelText: 'NIS',
                hintText: 'Número de Identificação Social',
                prefixIcon: Icons.assignment_ind,
              ),

              // 2. Localização e Contacto
              _secao('2. Localização e Contacto'),
              CustomIconTextField(
                controller: _comunidadeController,
                labelText: 'Comunidade',
                hintText: 'Nome do Povoado',
                prefixIcon: Icons.map,
              ),
              const SizedBox(height: 16),
              CustomIconTextField(
                controller: _pontoReferenciaController,
                labelText: 'Ponto de Referência',
                hintText: 'Ex: Próximo à igreja',
                prefixIcon: Icons.place,
              ),
              const SizedBox(height: 16),
              CustomIconTextField(
                controller: _telefoneController,
                labelText: 'Telefone',
                hintText: '(00) 00000-0000',
                prefixIcon: Icons.phone,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Tipo de Acesso',
                  prefixIcon: Icon(Icons.directions_car),
                  border: OutlineInputBorder(),
                ),
                value: _tipoAcesso,
                items: ['Estrada de terra', 'Asfalto', 'Trilha']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) => setState(() => _tipoAcesso = val),
              ),

              // 3. Composição Familiar (Representação simplificada)
              _secao('3. Composição Familiar'),
              const Text(
                'A lista de membros será gerenciada em um módulo específico.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Adicionar Membro'),
              ),

              // 4. Situação Socioeconómica
              _secao('4. Situação Socioeconómica'),
              CustomIconTextField(
                controller: _rendaController,
                labelText: 'Renda Mensal Bruta',
                hintText: 'Ex: 1320.00',
                prefixIcon: Icons.monetization_on,
              ),
              const SizedBox(height: 16),
              CustomIconTextField(
                controller: _atividadeController,
                labelText: 'Atividade Principal',
                hintText: 'Ex: Agricultor',
                prefixIcon: Icons.work,
              ),
              const SizedBox(height: 16),
              CustomIconTextField(
                controller: _dapController,
                labelText: 'DAP ou CAF',
                hintText: 'Número do documento',
                prefixIcon: Icons.description,
              ),

              // 5. Diagnóstico da Habitação Atual
              _secao('5. Diagnóstico da Habitação'),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Tipo de Construção',
                  prefixIcon: Icon(Icons.home),
                  border: OutlineInputBorder(),
                ),
                value: _tipoConstrucao,
                items: ['Alvenaria', 'Taipa', 'Madeira']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) => setState(() => _tipoConstrucao = val),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Situação da Cobertura',
                  prefixIcon: Icon(Icons.roofing),
                  border: OutlineInputBorder(),
                ),
                value: _situacaoCobertura,
                items: ['Telha', 'Zinco', 'Lona']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) => setState(() => _situacaoCobertura = val),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Abastecimento de Água',
                  prefixIcon: Icon(Icons.water_drop),
                  border: OutlineInputBorder(),
                ),
                value: _abastecimentoAgua,
                items: ['Cisterna', 'Poço', 'Encanada']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) => setState(() => _abastecimentoAgua = val),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Esgotamento Sanitário',
                  prefixIcon: Icon(Icons.cleaning_services),
                  border: OutlineInputBorder(),
                ),
                value: _esgotamentoSanitario,
                items: ['Fossa Séptica', 'Céu Aberto']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) => setState(() => _esgotamentoSanitario = val),
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                title: const Text('Possui Energia Elétrica?'),
                value: _possuiEnergiaEletrica,
                onChanged: (bool val) =>
                    setState(() => _possuiEnergiaEletrica = val),
              ),

              // 6. Mídia
              _secao('6. Mídia e Documentação'),
              Wrap(
                spacing: 10,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.camera_alt),
                    tooltip: 'Foto Fachada',
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.camera_indoor),
                    tooltip: 'Foto Interior',
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.document_scanner),
                    tooltip: 'Documentos',
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.draw),
                    tooltip: 'Assinatura',
                  ),
                ],
              ),

              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final familia = Familia(
                      nomeTitular: _nomeController.text,
                      cpf: _cpfController.text,
                      rg: _rgController.text,
                      dataNascimento: DateTime.now(), // temporário
                      sexo: _sexo ?? '',
                      estadoCivil: _estadoCivil ?? '',
                      nomeMae: _nomeMaeController.text,
                      nis: _nisController.text,
                      comunidade: _comunidadeController.text,
                      pontoReferencia: _pontoReferenciaController.text,
                      telefone: _telefoneController.text,
                      tipoAcesso: _tipoAcesso ?? '',
                      membros: [],
                      rendaMensalBruta:
                          double.tryParse(_rendaController.text) ?? 0.0,
                      atividadePrincipal: _atividadeController.text,
                      dapOuCaf: _dapController.text,
                      tipoConstrucao: _tipoConstrucao ?? '',
                      situacaoCobertura: _situacaoCobertura ?? '',
                      abastecimentoAgua: _abastecimentoAgua ?? '',
                      esgotamentoSanitario: _esgotamentoSanitario ?? '',
                      possuiEnergiaEletrica: _possuiEnergiaEletrica,
                    );

                    await DatabaseHelper.instance.insertFamilia(familia);
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Validado com sucesso!')),
                    );
                  }
                },
                child: const Text('Salvar Cadastro'),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 0),
    );
  }
}
