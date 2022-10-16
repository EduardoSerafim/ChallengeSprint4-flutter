import 'package:challangesprint4/pages/home_page.dart';
import 'package:challangesprint4/pages/robo_simulacao_page.dart';
import 'package:flutter/material.dart';

class PaginaInicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Container(width: 280,child: Image.asset('assets/imgs/inf-white.png'))),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.asset('assets/imgs/scanialogo.png'),
                const Divider(
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 70,
                ),
                const Text("Bem vindo ao painel de licitações da Scania", style: TextStyle(fontSize: 20, ),),
                const SizedBox(
                  height: 100,
                ),
                Container(
                  width: 250,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => RoboSimulacaoPage()));
                      },
                      child: const Text("Entrar", style: TextStyle(fontSize: 20),)
                  ),
                ), 
                const SizedBox(height:100),
                const Text("By Infinity - 2022", style: TextStyle(fontSize: 16),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
