import 'package:challangesprint4/models/licitacoesParticipando.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LicitacoesParticipandoPage extends StatefulWidget {
  @override
  State<LicitacoesParticipandoPage> createState() =>
      _LicitacoesParticipandoPageState();
}

class _LicitacoesParticipandoPageState
    extends State<LicitacoesParticipandoPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LicitacoesParticipando>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Licitações que estou participando'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: provider.licitacoes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(provider.licitacoes[index].descricao),
            subtitle: Text(' R\$${provider.licitacoes[index].valor}'),
           
          );
        },
      ),
    );
  }
}
