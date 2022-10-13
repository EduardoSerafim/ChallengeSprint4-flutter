import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  Future<Database> getDatabase() async {
    final path = join(await getDatabasesPath(), 'checkpoint.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    
    await db.execute(_licitacoes);
    
    await db.insert('licitacoes', {
      'descricao': '3 Caminhões para obras',
      'orgao': 'prefeitura de são paulo',
      'numeroProcesso': 12345678,
      'participando': false,
      'valor': 300000.00,
      'dataFinal': 50506060
    });
    
  }
   String get _licitacoes => '''
      CREATE TABLE IF NOT EXISTS licitacoes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        descricao TEXT,
        orgao TEXT,
        participando INTEGER,
        numeroProcesso INTEGER,
        valor REAL,
        dataFinal INTEGER
    );

    ''';
}
