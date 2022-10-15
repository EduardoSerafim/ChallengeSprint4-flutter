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
      'orgao': 'Prefeitura de são paulo - SP',
      'numeroProcesso': 12345678,
      'participando': false,
      'valor': 1000000.00,
      'dataFinal': 50506060
    });
    await db.insert('licitacoes', {
      'descricao': 'Aquisição de caminhão equipado com cabine suplementar e caçamba basculante',
      'orgao': 'Prefeitura Municipal de Bom Despacho - MG',
      'numeroProcesso': 96352874,
      'participando': false,
      'valor': 200000.00,
      'dataFinal': 50506060
    });
    await db.insert('licitacoes', {
      'descricao': 'Aquisição de 01 (um) caminhão caçamba,',
      'orgao': 'Prefeitura Municipal de Santo Antônio da Patrulha - RS',
      'numeroProcesso': 85514736,
      'participando': false,
      'valor': 350000.00,
      'dataFinal': 50506060
    });
    await db.insert('licitacoes', {
      'descricao': 'Aquisição de 1(um) caminhão caçamba basculante zero km, 1(um) caminhão tipo toco, equipado com tanque pipa, zero km',
      'orgao': 'PREFEITURA MUNICIPAL DE JEQUITAÍ - MG',
      'numeroProcesso': 74125836,
      'participando': false,
      'valor': 800000.00,
      'dataFinal': 50506060
    });
    
    await db.insert('licitacoes', {
      'descricao': 'AQUISIÇÃO DE UM CAMINHÃO CAÇAMBA BASCULANTE PARA ATENDER AS NECESSIDADES DA SECRETARIA MUNICIPAL DE OBRAS',
      'orgao': 'Prefeitura Municipal de Piratini - RS',
      'numeroProcesso': 15975382,
      'participando': false,
      'valor': 150000.00,
      'dataFinal': 50506060
    });
    await db.insert('licitacoes', {
      'descricao': 'LOCAÇÃO DE VEÍCULOS PARA EXECUÇÃO DOS SERVIÇOS DE RETIRADA E TRANSPORTE DE REJEITOS E RESIDUOS URBANOS E DE CONSTRUÇÃO CIVIL COM REMOÇÃO PARA LOCAL ADEQUADO, POR MEIO DE CAÇAMBA ESTACIONÁRIA EM CAMINHÃO TIPO SISTEMA ROLL- ON/OFF',
      'orgao': 'Prefeitura Municipal de Touros - RN',
      'numeroProcesso': 21354698,
      'participando': false,
      'valor': 950000.00,
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
