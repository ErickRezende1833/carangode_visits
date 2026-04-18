import 'package:cloud_firestore/cloud_firestore.dart';

import '../database/visita_dao.dart';
import '../models/visita.dart';

class SyncService {
  final VisitaDao _dao = VisitaDao();

  Future<void> syncVisitas() async {
    try {
      // pega tudo que ainda não foi sincronizado
      List<Visita> pendentes = await _dao.listarNaoSincronizadas();

      if (pendentes.isEmpty) {
        print("Nada para sincronizar");
        return;
      }

      // envia para o Firebase
      for (Visita v in pendentes) {
        await FirebaseFirestore.instance.collection('visitas').add({
          'nome': v.nome,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // marca como sincronizado no SQLite
        await _dao.marcarComoSincronizado(v.id!);

        print("Sincronizado: ${v.nome}");
      }

      print("Sync finalizado com sucesso!");
    } catch (e) {
      print("Erro no sync: $e");
    }
  }
}