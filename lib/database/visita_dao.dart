import 'package:sqflite/sqflite.dart';

import '../models/visita.dart';
import 'database_helper.dart';

class VisitaDao {
  Future<int> inserirVisita(Visita visita) async {
    final Database db = await DatabaseHelper.instance.database;

    return db.insert(
      'visitas',
      visita.toMap(),
    );
  }

  Future<List<Visita>> listarVisitas() async {
    final Database db = await DatabaseHelper.instance.database;

    final List<Map<String, dynamic>> result = await db.query(
      'visitas',
      orderBy: 'id DESC',
    );

    return result.map((map) => Visita.fromMap(map)).toList();
  }
}