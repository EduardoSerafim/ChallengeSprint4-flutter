import 'package:flutter/material.dart';

class SobrePage extends StatelessWidget {




  @override
  Widget build(BuildContext context) {

  Future<void> _showDialog() async {
    return showDialog<void>(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Integrantes da infinity"),
            content: SingleChildScrollView(
              child: Column(
                children: const [
                  Text("Bruno Figueiredo Sousa"),
                  Text("Eduardo Fernando Serafim Santos"),
                  Text("Felipe Baptista"),
                  Text("Leonardo Amorim Rombalde"),
                  Text("Vitor Rezende Passos"),
                  
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text('Voltar'))
            ],
          );
        });
  }

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Sobre nós",
          ),
          automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              children:  [
                const SizedBox(height: 20,),
                Image.asset('assets/imgs/inf-white-black.png'),
                const SizedBox(height: 20,),
                Text("Nossa proposta", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
                Container(
                  width: 350,
                  child: const Text("Nossa proposta consiste em criar um robô que acessa sites de licitações governamentais em busca de licitações para a compra de caminhões e ônibus. isso ajudaria a scania a ter mais controle e facilidade em lidar com licitações, podendo assim, participar de varios processos de licitações, e consequentemente, ter mais chance de vender caminhões. para o desenvolvimento do robô, será usado o selenium, uma biblioteca de automação para web que suporta varias linguagens, no nosso caso, iremos utilizar java. basicamente, o robô busca as informações sobre as licitações na internet e armazena em um banco de dados oracle.",
                  style: TextStyle(fontSize: 18),
                  ),
                )
  
                
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.info),
        onPressed: () {
          _showDialog();
        },
      ),
    );
  }
}
