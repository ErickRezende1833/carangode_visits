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

    return result.map((map) {
      return Visita(
        id: map['id'],
        nome: map['nome'],
        synced: map['synced'] == 1,
      );
    }).toList();
  }

  Future<void> marcarComoSincronizado(int id) async {
    final Database db = await DatabaseHelper.instance.database;

    await db.update(
      'visitas',
      {'synced': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Visita>> listarNaoSincronizadas() async {
    final Database db = await DatabaseHelper.instance.database;

    final List<Map<String, dynamic>> result = await db.query(
      'visitas',
      where: 'synced = ?',
      whereArgs: [0],
    );

    return result.map((map) {
      return Visita(
        id: map['id'],
        nome: map['nome'],
        synced: false,
      );
    }).toList();
  }
}