import 'package:cloud_firestore/cloud_firestore.dart';

import '../database/database_helper.dart';
import '../models/familiaModel.dart';

class SyncService {
  bool _isSyncing = false;

  Future<void> syncFamilias() async {
    if (_isSyncing) {
      print("Sync já em andamento...");
      return;
    }

    _isSyncing = true;

    try {
      final db = await DatabaseHelper.instance.database;

      // 🔍 pega só os não sincronizados
      final result = await db.query(
        'familias',
        where: 'synced = ?',
        whereArgs: [0],
      );

      if (result.isEmpty) {
        print("Nada para sincronizar");
        return;
      }

      for (final item in result) {
        try {
          final familia = Familia.fromMap(item);

          if (familia.id == null) continue;

          // ☁ envia para Firestore
          await FirebaseFirestore.instance
              .collection('familias')
              .doc(familia.id.toString())
              .set({
            'nomeTitular': familia.nomeTitular,
            'cpf': familia.cpf,
            'rg': familia.rg,
            'sexo': familia.sexo,
            'estadoCivil': familia.estadoCivil,
            'nomeMae': familia.nomeMae,
            'nis': familia.nis,
            'comunidade': familia.comunidade,
            'pontoReferencia': familia.pontoReferencia,
            'telefone': familia.telefone,
            'tipoAcesso': familia.tipoAcesso,
            'rendaMensalBruta': familia.rendaMensalBruta,
            'atividadePrincipal': familia.atividadePrincipal,
            'dapOuCaf': familia.dapOuCaf,
            'tipoConstrucao': familia.tipoConstrucao,
            'situacaoCobertura': familia.situacaoCobertura,
            'abastecimentoAgua': familia.abastecimentoAgua,
            'esgotamentoSanitario': familia.esgotamentoSanitario,
            'possuiEnergiaEletrica': familia.possuiEnergiaEletrica,
            'timestamp': FieldValue.serverTimestamp(),
          });

          // 💾 marca como sincronizado no SQLite
          await db.update(
            'familias',
            {'synced': 1},
            where: 'id = ?',
            whereArgs: [familia.id],
          );

          print("Sincronizado: ${familia.nomeTitular}");
        } catch (e) {
          print("Erro ao sincronizar item: $e");
        }
      }

      print("Sync finalizado com sucesso!");
    } catch (e) {
      print("Erro geral no sync: $e");
    } finally {
      _isSyncing = false;
    }
  }
}