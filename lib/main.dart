
import 'package:challangesprint4/models/licitacoesParticipando.dart';
import 'package:challangesprint4/pages/licitacao_cadastro_page.dart';
import 'package:challangesprint4/pages/licitacao_detalhe_page.dart';
import 'package:challangesprint4/pages/pagina_inicio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/licitacao.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LicitacoesParticipando(),
      child: MaterialApp(
        title: 'Checkpoint 3 ',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        routes: {
          '/': (context) => PaginaInicio(),
          'licitacao-lista': (context) => HomePage(),
          '/licitacao-cadastro':(context) =>  LicitacaoCadastroPage(),
          '/licitacao-detalhes': (context) => const LicitacaoDetalhePage()
        },
        initialRoute: '/',
      ),
    );
  }
}

