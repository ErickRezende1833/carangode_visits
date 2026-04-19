import 'package:sqflite/sqflite.dart';

import '../models/familiaModel.dart';
import 'database_helper.dart';

class FamiliaDao {
  final dbHelper = DatabaseHelper.instance;

  Future<int> inserir(Familia familia) async {
    final Database db = await dbHelper.database;

    final map = familia.toMap();
    map['synced'] = 0;

    return await db.insert(
      'familias',
      map,
    );
  }

  Future<List<Familia>> listarFamilias() async {
    final Database db = await dbHelper.database;

    final List<Map<String, dynamic>> result = await db.query(
      'familias',
      orderBy: 'id DESC',
    );

    return result.map((map) => Familia.fromMap(map)).toList();
  }

  Future<List<Familia>> listarNaoSincronizadas() async {
    final Database db = await dbHelper.database;

    final List<Map<String, dynamic>> result = await db.query(
      'familias',
      where: 'synced = ?',
      whereArgs: [0],
    );

    return result.map((map) => Familia.fromMap(map)).toList();
  }

  Future<void> marcarComoSincronizado(int id) async {
    final Database db = await dbHelper.database;

    await db.update(
      'familias',
      {'synced': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}