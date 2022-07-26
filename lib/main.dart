import 'package:flutter/material.dart';

void main() => runApp(Formulario());

class Formulario extends StatelessWidget {
  // Raiz da aplicação
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Cadastrando produto"),
        ),
      ),
    );
  }
}


