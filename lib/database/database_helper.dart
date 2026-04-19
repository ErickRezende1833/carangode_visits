import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:carangode_visits_app/models/familiaModel.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'carangode_visits.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE familias (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nomeTitular TEXT,
    cpf TEXT,
    rg TEXT,
    dataNascimento TEXT,
    sexo TEXT,
    estadoCivil TEXT,
    nomeMae TEXT,
    nis TEXT,
    comunidade TEXT,
    pontoReferencia TEXT,
    telefone TEXT,
    tipoAcesso TEXT,
    membros TEXT,
    rendaMensalBruta REAL,
    atividadePrincipal TEXT,
    dapOuCaf TEXT,
    tipoConstrucao TEXT,
    situacaoCobertura TEXT,
    abastecimentoAgua TEXT,
    esgotamentoSanitario TEXT,
    possuiEnergiaEletrica INTEGER,
    pathFotoFachada TEXT,
    pathFotoInterior TEXT,
    pathFotoDocumentos TEXT,
    pathAssinaturaDigital TEXT,
    synced INTEGER DEFAULT 0
  )
''');
  }
  Future<int> insertFamilia(Familia familia) async {
  final db = await database;

  final map = familia.toMap();
  map['synced'] = 0; 

  return await db.insert(
    'familias',
    map,
  );
}

  Future<List<Familia>> getAllFamilias() async {
  final db = await database;
  final result = await db.query('familias');

  return result.map((e) => Familia.fromMap(e)).toList();
  }
}