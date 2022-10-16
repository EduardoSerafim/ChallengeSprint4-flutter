import 'dart:async';

import 'package:challangesprint4/pages/home_page.dart';
import 'package:flutter/material.dart';

class RoboSimulacaoPage extends StatefulWidget {
  @override
  State<RoboSimulacaoPage> createState() => _RoboSimulacaoPageState();
}

class _RoboSimulacaoPageState extends State<RoboSimulacaoPage> {
  var textoBotao = 'Ativar e buscar';
  bool visivel = false;

  void buscarLicitacoes() {
    setState(() {
      textoBotao = 'Buscando licitações';
      visivel = true;
      Timer(const Duration(seconds: 5), () => mudarDePagina());
    });
  }

  void mudarDePagina() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Buscar Licitações",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Para buscar as licitações, é necessário ativar o robô que fará a busca nos sites de licitação",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                width: 250,
                child: OutlinedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.purple)))),
                    child: Text(
                      textoBotao,
                      style: const TextStyle(fontSize: 20),
                    ),
                    onPressed: buscarLicitacoes),
              ),
              const SizedBox(
                height: 50,
              ),
              Visibility(
                visible: visivel,
                child: CircularProgressIndicator(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
