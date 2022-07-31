// Database
import 'dart:typed_data';

import 'package:prod_storage/database/app_database.dart';
// Models
import 'package:prod_storage/models/produto.dart';
import 'package:sqflite/sqflite.dart';


class ProductDao {
  // Classe que guardará as funções de comunicação com o banco

  // Variáveis para o app_database.dart
  static const String createTable =
    'CREATE TABLE $_tabela ('
      '$_primary INTEGER PRIMARY KEY,'
      '$_nomeProduto TEXT,'
      '$_valorProduto REAL,'
      '$_qtd INTEGER,'
      '$_imagemBytes BLOB)';

  static const String _tabela = 'produtos';
  static const String _primary = 'codigo';
  static const String _nomeProduto = 'nome';
  static const String _valorProduto = 'valor';
  static const String _imagemBytes = 'imagem';
  static const String _qtd = 'qtd';

  // Funções

  Future<int> salvarProduto(Produto produto) async {
    // Essa função salva o produto no banco de dados

    // aguarda o término do getDB para guardar o valor na variável db
    final Database db = await getDB();
    // guarda o mapa do produto, já que o insert usa mapa no request
    Map<String, dynamic> mapaProduto = _toMap(produto);

    // Faz a requisição
    return db.insert(_tabela, mapaProduto);

  }

  Future<List<Produto>> todosProdutos() async {

    final Database db = await getDB();
    final List<Map<String, dynamic>> resultado = await db.rawQuery('SELECT * FROM $_tabela');

    Future<List<Produto>> produtos = _toList(resultado);

    return produtos;
  }


  // Helpers

  Future<List<Produto>> _toList(List<Map<String, dynamic>> resultado) async {
    // Converte o resultado da query SQL para uma Lista contendo produtos

    final List<Produto> produtos = [];

    // getImage('1');
    for (Map<String, dynamic> linha in resultado){

      final Database db = await getDB();
      final query = await db.rawQuery("SELECT $_imagemBytes FROM $_tabela WHERE $_primary = ${linha[_primary]}");
      Uint8List imagem = Uint8List.fromList([]);

      for(Map<String, dynamic> row in query){
        print(row);
        imagem = row[_imagemBytes];
      }

      produtos.add(Produto(
          linha[_nomeProduto],
          linha[_qtd],
          linha[_valorProduto],
          imagem
      ));
    }
    return produtos;
  }

  Map<String, dynamic> _toMap(Produto produto) {
    // Essa função converte o produto em mapa

    // criação do mapa que será preenchido ao longo da função
    final Map<String, dynamic> mapaProduto = {};

    // Não acrescenta o código pois se auto-incrementa
    mapaProduto['nome'] = produto.nome;
    mapaProduto['valor'] = produto.valor;
    mapaProduto['qtd'] = produto.quantidade;
    mapaProduto['imagem'] = produto.imagem;

    // Retorna o mapa
    return mapaProduto;

  }

}