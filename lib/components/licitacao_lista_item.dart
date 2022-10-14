import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/licitacao.dart';

class LicitacaoListaItem extends StatelessWidget {
  final Licitacao licitacao;
  const LicitacaoListaItem({Key? key, required this.licitacao, List<Licitacao>? licitacoes})
      : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return ListTile(

      leading: const CircleAvatar(
        backgroundColor: Colors.purple,
        child: Icon(Icons.fire_truck, size: 20, color: Colors.white),
      ),
      title: Text(licitacao.descricao),
      subtitle: Text(licitacao.orgao),
      trailing: Text(
        NumberFormat.simpleCurrency(locale: 'pt_BR').format(licitacao.valor),
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
      
      onTap: () {
        Navigator.pushNamed(context, '/licitacao-detalhes',
            arguments: licitacao,);
      },
    );
  }
}
