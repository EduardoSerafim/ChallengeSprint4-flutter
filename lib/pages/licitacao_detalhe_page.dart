import 'package:challangesprint4/models/licitacoesParticipando.dart';
import 'package:challangesprint4/pages/home_page.dart';
import 'package:challangesprint4/pages/licitacao_lista_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/licitacao.dart';
import '../repositories/licitacao_repository.dart';

class LicitacaoDetalhePage extends StatefulWidget {
  const LicitacaoDetalhePage({Key? key}) : super(key: key);

  @override
  State<LicitacaoDetalhePage> createState() => _LicitacaoDetalhePageState();
}

class _LicitacaoDetalhePageState extends State<LicitacaoDetalhePage> {
  bool isChecked = false;
  final _licitacaoRepository = LicitacaoRepository();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LicitacoesParticipando>(context);

    final licitacao = ModalRoute.of(context)!.settings.arguments as Licitacao;

    if (licitacao.participando == 1) {
      isChecked = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes da licitação"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Table(
                border: TableBorder.all(),
                children: [
                  TableRow(
                    children: [
                      const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Descrição da licitação",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                            child: Text(licitacao.descricao,
                                style: const TextStyle(
                                  fontSize: 20,
                                ))),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Orgão requisitor",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(
                            child: Text(licitacao.orgao,
                                style: TextStyle(
                                  fontSize: 20,
                                ))),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Número do processo",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(
                            child: Text(licitacao.numeroProcesso.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                ))),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Valor",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Center(
                              child: Text(
                                  NumberFormat.simpleCurrency(locale: 'pt_BR')
                                      .format(licitacao.valor),
                                  style: TextStyle(
                                    fontSize: 20,
                                  )))),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Data de fechamento",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Center(
                              child: Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(licitacao.dataFinal),
                                  style: TextStyle(
                                    fontSize: 20,
                                  )))),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "PARTICIPAR DA LICITAÇÂO",
                style: TextStyle(
                    color: Colors.purple,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 7,
              ),
              Transform.scale(
                scale: 1.5,
                child: Checkbox(
                  checkColor: Color.fromARGB(255, 0, 252, 8),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                      if (value) {
                        licitacao.participando = 1;
                      } else {
                        licitacao.participando = 0;
                      }

                      _licitacaoRepository.editarParticipando(licitacao);

                      if (licitacao.participando == 1) {
                        provider.add(licitacao);
                      } else {
                        provider.remove(licitacao);
                      }
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 250,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                    onPressed: () async {
                      await _licitacaoRepository
                          .removerLicitacao(licitacao.id!);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Licitação removida com sucesso")));
                      setState(() {
                        provider.remove(licitacao);
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>LicitacaoListaPage()));
                      });
                    },
                    child: Text(
                      "Descartar licitação",
                      style: TextStyle(fontSize: 20),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
