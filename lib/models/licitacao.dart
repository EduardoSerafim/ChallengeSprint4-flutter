class Licitacao {
  int? id;
  String descricao;
  int numeroProcesso;
  String orgao;
  double valor;
  DateTime dataFinal;
  int? participando;

  Licitacao(
      {this.id,
      this.participando,
      required this.descricao,
      required this.valor,
      required this.orgao,
      required this.numeroProcesso,
      required this.dataFinal});

 @override
  bool operator ==(Object other) => other is Licitacao && other.id == id;
}
