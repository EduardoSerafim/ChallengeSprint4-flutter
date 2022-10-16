import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/licitacao_lista_item.dart';
import '../models/licitacao.dart';
import '../repositories/licitacao_repository.dart';

class LicitacoesParticipandoPage extends StatefulWidget {
  @override
  State<LicitacoesParticipandoPage> createState() =>
      _LicitacoesParticipandoPageState();
}

class _LicitacoesParticipandoPageState
    extends State<LicitacoesParticipandoPage> {
  late Future<List<Licitacao>> _futureLicitacoes;
  final _licitacaoRepository = LicitacaoRepository();

  @override
  void initState() {
    carregarLicitacoesParticipando();
    super.initState();
  }

  void carregarLicitacoesParticipando() {
    _futureLicitacoes = _licitacaoRepository.listarLicitacoesParticipando();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Licitações que estou participando'),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<Licitacao>>(
          future: _futureLicitacoes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              final licitacoes = snapshot.data ?? [];

              return ListView.separated(
                itemCount: licitacoes.length,
                itemBuilder: (context, index) {
                  final licitacao = licitacoes[index];
                  return LicitacaoListaItem(
                    licitacao: licitacao,
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              );
            }
            return Container();
          }
        ),
    );
  }
}

