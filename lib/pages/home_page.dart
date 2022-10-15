import 'package:challangesprint4/pages/licitacoes_participando_page.dart';
import 'package:challangesprint4/pages/sobre_page.dart';
import 'package:flutter/material.dart';

import 'licitacao_lista_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController pc;

  @override
  initState(){
    super.initState();
    pc = PageController( initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        onPageChanged: setPaginaAtual,
        children:  [
          const LicitacaoListaPage(),
          LicitacoesParticipandoPage(),
          SobrePage()

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Todas as Licitações"),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt_sharp), label: 'Participando'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Sobre'),

        ],
         onTap: (pagina) {
          pc.animateToPage(
            pagina,
            duration: const Duration(milliseconds: 400),
            curve: Curves.ease,
          );
        },
      ),
      
    );
  }
}
