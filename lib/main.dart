import 'package:flutter/material.dart';

import './screens/lista.dart';


void main() => runApp(const InvetarioProdutos());

class InvetarioProdutos extends StatelessWidget {
  const InvetarioProdutos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Inventário de Produtos - By: Caio Luppo",  // Título do App
      home: ListaProdutos(),  // Tela principal
    );
  }
}
