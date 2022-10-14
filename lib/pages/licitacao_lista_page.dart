import 'package:challangesprint4/models/licitacoesParticipando.dart';
import 'package:challangesprint4/pages/licitacao_cadastro_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../components/licitacao_lista_item.dart';
import '../models/licitacao.dart';
import '../repositories/licitacao_repository.dart';

class LicitacaoListaPage extends StatefulWidget {
  const LicitacaoListaPage({Key? key}) : super(key: key);

  @override
  State<LicitacaoListaPage> createState() => _LicitacaoListaPageState();
}

class _LicitacaoListaPageState extends State<LicitacaoListaPage> {
  final _licitacaoRepository = LicitacaoRepository();
  late Future<List<Licitacao>> _futureLicitacoes;

  @override
  void initState() {
    carregarLicitacoes();
    super.initState();
  }

  void carregarLicitacoes() {
    _futureLicitacoes = _licitacaoRepository.listarLicitacoes();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LicitacoesParticipando>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Licitações de caminhões")),
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
                return Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) async {
                            var success = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LicitacaoCadastroPage(
                                        licitacaoParaEdicao: licitacao),
                              ),
                            ) as bool?;
                            if (success != null && success) {
                              setState(() {
                                provider.remove(licitacao);
                                carregarLicitacoes();
                              });
                            }
                          },
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: 'Editar',
                        )
                      ],
                    ),
                    child: LicitacaoListaItem(
                      licitacao: licitacao,
                    ));
              },
              separatorBuilder: (context, index) => const Divider(),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? licitacaoCadastrada = await Navigator.of(context)
              .pushNamed('/licitacao-cadastro') as bool?;

          if (licitacaoCadastrada != null && licitacaoCadastrada) {
            setState(() {
              carregarLicitacoes();
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
