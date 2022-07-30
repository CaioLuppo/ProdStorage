import 'package:flutter/material.dart';

import './screens/lista.dart';


void main() => runApp(InvetarioProdutos());

class InvetarioProdutos extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ProdStorage - By: Caio Luppo",  // Título do App

      theme: ThemeData(  // Tema do aplicativo, colorScheme -> tema geral
        colorSchemeSeed: const Color.fromARGB(255, 79, 48, 0),
        brightness: Brightness.light,
        dividerColor: Colors.grey
      ),

      darkTheme: ThemeData(  // Modo escuro do celular
        colorSchemeSeed: const Color.fromARGB(255, 79, 48, 0),
        brightness: Brightness.dark,
        dividerColor: Colors.white
      ),

      home: ListaProdutos(),  // Tela principal
    );
  }
}
