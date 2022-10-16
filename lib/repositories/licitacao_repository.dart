import '../database/database_manager.dart';
import '../models/licitacao.dart';

class LicitacaoRepository {
  Future<List<Licitacao>> listarLicitacoes() async {
    final db = await DatabaseManager().getDatabase();
    final List<Map<String, dynamic>> rows = await db.query('licitacoes');
    late var translateBoolean;
    return rows
        .map((row) => Licitacao(
            id: row['id'],
            descricao: row['descricao'],
            orgao: row['orgao'],
            numeroProcesso: row['numeroProcesso'],
            valor: row['valor'],
            participando: row['participando'],
            dataFinal: DateTime.fromMillisecondsSinceEpoch(row['dataFinal'])))
        .toList();
  }
  
  Future<List<Licitacao>> listarLicitacoesParticipando() async {
    final db = await DatabaseManager().getDatabase();
    final List<Map<String, dynamic>> rows = await db.query('licitacoes', where: 'participando = true' );
    late var translateBoolean;
    return rows
        .map((row) => Licitacao(
            id: row['id'],
            descricao: row['descricao'],
            orgao: row['orgao'],
            numeroProcesso: row['numeroProcesso'],
            valor: row['valor'],
            participando: row['participando'],
            dataFinal: DateTime.fromMillisecondsSinceEpoch(row['dataFinal'])))
        .toList();
  }

  Future<void> cadastrarLicitacao(Licitacao licitacao) async {
    final db = await DatabaseManager().getDatabase();

    db.insert('licitacoes', {
      "id": licitacao.id,
      "descricao": licitacao.descricao,
      "orgao": licitacao.orgao,
      "participando": licitacao.participando,
      "numeroProcesso": licitacao.numeroProcesso,
      "dataFinal": licitacao.dataFinal.millisecondsSinceEpoch,
      "valor": licitacao.valor
    });
  }

  Future<int> editarLicitacao(Licitacao licitacao) async {
    final db = await DatabaseManager().getDatabase();
    return db.update(
        'licitacoes',
        {
          "id": licitacao.id,
          "participando": licitacao.participando,
          "descricao": licitacao.descricao,
          "orgao": licitacao.orgao,
          "numeroProcesso": licitacao.numeroProcesso,
          "dataFinal": licitacao.dataFinal.millisecondsSinceEpoch
        },
        where: 'id = ?',
        whereArgs: [licitacao.id]);
  }
  Future<int> editarParticipando(Licitacao licitacao) async {
    final db = await DatabaseManager().getDatabase();
    return db.update(
        'licitacoes',
        {
          "participando": licitacao.participando,
        },
        where: 'id = ?',
        whereArgs: [licitacao.id]);
  }

  Future<void> removerLicitacao(int id) async {
    final db = await DatabaseManager().getDatabase();
    await db.delete('licitacoes', where: 'id = ?', whereArgs: [id]);
  }
}
