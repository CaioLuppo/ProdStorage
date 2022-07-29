import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../models/produto.dart';


class Formulario extends StatefulWidget {

  @override
  State<Formulario> createState() => _FormularioState();
}


class _FormularioState extends State<Formulario>{

  // Imagem
  File? _imagem;

  Future _pegaImagem() async {
    final imagem = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagem == null) return "Imagem não selecionada";

    final localTemporario = File(imagem.path);

    setState(() {
      _imagem = localTemporario;
    });
  }

  // Controladores que receberam o valor do input
  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorQuantidade = TextEditingController();
  final TextEditingController _controladorValor = TextEditingController();

  // Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cadastrando produto"),
        ),
        body: SingleChildScrollView(
          child: Padding(  // Adiciona espaçamento
            padding: const EdgeInsets.all(24.0),
            child: Column(children: <Widget>[

              Column(
                children: [
                  const Text(
                    "Imagem do Produto:",
                    style: TextStyle(fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child:
                          _imagem != null
                              ? Image.file(_imagem!, fit: BoxFit.fill,)
                              : ElevatedButton(
                              onPressed: _pegaImagem,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(Icons.image_search, size: 40,),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.0),
                                    child: Text("Pegar imagem da galeria",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),),
                                  ),
                                ],
                              ),
                          ),
                      ),
                    ),
                  ),
                ],
              ),

              // Inputs
              TextField(
                controller: _controladorNome,
                decoration: const InputDecoration( labelText: "Nome"),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: // Texto
                TextField(
                  controller: _controladorQuantidade,
                  decoration: const InputDecoration( labelText: "Quantidade"),
                  keyboardType: TextInputType.number,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: // Texto
                TextField(
                  controller: _controladorValor,
                  decoration: const InputDecoration( labelText: "Valor" ),
                  keyboardType: TextInputType.number,
                ),
              ),

              // Botão de Cadastrar
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: // Botão
                ElevatedButton(
                  onPressed: () => _criaProduto(context),
                  child: const Text("Cadastrar"),
                ),
              ),
            ]),
          ),
        ),
    );
  }

  void _criaProduto(BuildContext context) {
    final nome = _controladorNome.text;
    final quantidade = int.tryParse(_controladorQuantidade.text);
    final valor = double.tryParse(_controladorValor.text);
    const imagem = ''; // Temporário, até implementar image picker

    if (nome != '' && quantidade != null && valor != null) {
      final Produto novoProduto = Produto(nome, quantidade, valor, imagem);
      Navigator.pop(context, novoProduto);
    }
    
  }
}