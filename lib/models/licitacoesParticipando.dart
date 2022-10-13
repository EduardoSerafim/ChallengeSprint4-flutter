import 'package:challangesprint4/models/licitacao.dart';
import 'package:flutter/cupertino.dart';

class LicitacoesParticipando extends ChangeNotifier {
  final List<Licitacao> _licitacoes = [];

  List<Licitacao> get licitacoes => _licitacoes;

  void add(Licitacao licitacao) {
    _licitacoes.add(licitacao);
    print(licitacao.descricao + 'Adicionado');
    notifyListeners();
  }

  void remove(Licitacao licitacao) {
    _licitacoes.remove(licitacao);
    print(licitacao.descricao + 'Removido');
    notifyListeners();
  }

}
