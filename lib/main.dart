import 'package:flutter/material.dart';

import './models/produto.dart';


void main() => runApp(Formulario());

class Formulario extends StatelessWidget {
  // Raiz da aplicação

  // Controladores que receberam o valor do input
  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorQuantidade = TextEditingController();
  final TextEditingController _controladorValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        appBar: AppBar(
          title: const Text("Cadastrando produto"),
        ),

        body: Column(
          children: <Widget>[

            // Inputs
            TextField( controller: _controladorNome,),
            TextField( controller: _controladorQuantidade,),
            TextField( controller: _controladorValor,),

            // Botão de Cadastrar
            ElevatedButton(
                onPressed: () {
                  final nome = _controladorNome.text;
                  final quantidade = int.tryParse(_controladorQuantidade.text);
                  final valor = double.tryParse(_controladorValor.text);

                  final Produto novoProduto = Produto(nome, quantidade, valor);
                },
                child: const Text("Cadastrar"),
            ),

          ]

        ),

      ),
    );
  }
}


