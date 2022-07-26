import 'package:flutter/material.dart';

import './screens/lista.dart';


void main() => runApp(InvetarioProdutos());

class InvetarioProdutos extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Inventário de Produtos - By: Caio Luppo",  // Título do App

      theme: ThemeData(  // Tema do aplicativo, colorScheme -> tema geral
        colorSchemeSeed: const Color.fromARGB(255, 79, 48, 0),
        brightness: Brightness.light,
      ),

      darkTheme: ThemeData(  // Modo escuro do celular
        colorSchemeSeed: const Color.fromARGB(255, 79, 48, 0),
        brightness: Brightness.dark,
      ),

      home: ListaProdutos(),  // Tela principal
    );
  }
}
