import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/licitacao.dart';
import '../repositories/licitacao_repository.dart';

class LicitacaoCadastroPage extends StatefulWidget {
  Licitacao? licitacaoParaEdicao;
  LicitacaoCadastroPage({Key? key, this.licitacaoParaEdicao}) : super(key: key);

  @override
  State<LicitacaoCadastroPage> createState() => _LicitacaoCadastroPageState();
}

class _LicitacaoCadastroPageState extends State<LicitacaoCadastroPage> {
  final _licitacaoRepository = LicitacaoRepository();

  final _descricaoController = TextEditingController();
  final _orgaoController = TextEditingController();
  final _valorController = TextEditingController();
  final _numeroProcessoController = TextEditingController();
  final _dataFinalController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (const Text("Cadastrar licitação")),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildDescricao(),
                const SizedBox(height: 20),
                _buildOrgao(),
                const SizedBox(height: 20),
                _buildNumeroProcesso(),
                const SizedBox(height: 20),
                _buildValor(),
                const SizedBox(height: 20),
                _buildDataFinal(),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                _buildButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _buildButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Cadastrar'),
        ),
        onPressed: () async {
          final isValid = _formKey.currentState!.validate();
          if (isValid) {
            final descricao = _descricaoController.text;
            final orgao = _orgaoController.text;
            final numeroProcesso = int.parse(_numeroProcessoController.text);
            final valor = double.parse(_valorController.text);
            final dataFinal =
                DateFormat('dd/MM/yyyy').parse(_dataFinalController.text);
            final licitacao = Licitacao(
                descricao: descricao,
                orgao: orgao,
                numeroProcesso: numeroProcesso,
                valor: valor,
                participando: 0,
                dataFinal: dataFinal);

            try {
              if (widget.licitacaoParaEdicao != null) {
                licitacao.id = widget.licitacaoParaEdicao!.id;
                await _licitacaoRepository.editarLicitacao(licitacao);
              } else {
                await _licitacaoRepository.cadastrarLicitacao(licitacao);
              }

              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Licitação cadastrado com sucesso'),
              ));

              Navigator.of(context).pop(true);
            } catch (e) {
              Navigator.of(context).pop(false);
            }
          }
        },
      ),
    );
  }

  TextFormField _buildDescricao() {
    return TextFormField(
      controller: _descricaoController,
      decoration: const InputDecoration(
        hintText: 'Descrição da licitação',
        labelText: 'Descrição',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.fire_truck),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe um descrição válida';
        }
        return null;
      },
    );
  }

  TextFormField _buildOrgao() {
    return TextFormField(
      controller: _orgaoController,
      decoration: const InputDecoration(
          hintText: 'Orgão responsável',
          labelText: 'Orgão',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.account_balance_rounded)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe um orgão válido';
        }
        return null;
      },
    );
  }

  TextFormField _buildNumeroProcesso() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _numeroProcessoController,
      decoration: const InputDecoration(
          hintText: 'Número do processo',
          labelText: 'Número do processo',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.numbers)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe um numero válido';
        }
        if (value.length != 8) {
          return 'Número do processo deve ter 8 caracteres ';
        }
        return null;
      },
    );
  }

  TextFormField _buildValor() {
    return TextFormField(
      controller: _valorController,
      decoration: const InputDecoration(
        hintText: 'Informe o valor',
        labelText: 'Valor',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.money),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe um Valor';
        }
        final valor = NumberFormat.currency(locale: 'pt_BR')
            .parse(_valorController.text.replaceAll('R\$', ''));
        if (valor <= 0) {
          return 'Informe um valor maior que zero';
        }

        return null;
      },
    );
  }

  TextFormField _buildDataFinal() {
    return TextFormField(
      controller: _dataFinalController,
      decoration: const InputDecoration(
        hintText: 'Informe a Data de fechamento',
        labelText: 'Data de fechamento',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.calendar_month),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());

        DateTime? dataSelecionada = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (dataSelecionada != null) {
          _dataFinalController.text =
              DateFormat('dd/MM/yyyy').format(dataSelecionada);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe uma Data';
        }

        try {
          DateFormat('dd/MM/yyyy').parse(value);
        } on FormatException {
          return 'Formato de data inválida';
        }

        return null;
      },
    );
  }
}
