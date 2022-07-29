// SQFlite
// Database
import 'package:formulario/database/app_database.dart';
// Models
import 'package:formulario/models/produto.dart';
import 'package:sqflite/sqflite.dart';


class Contact {
  // Classe que guardará as funções de comunicação com o banco

  // Variáveis para o app_database.dart
  static const String createTable =
    'CREATE TABLE $_tabela ('
      '$_primary INTEGER PRIMARY KEY,'
      '$_nomeProduto TEXT,'
      '$_valorProduto REAL,'
      '$_qtd INTEGER,'
      '$_imagemProdutoBase64 TEXT)';

  static const String _tabela = 'produtos';
  static const String _primary = 'codigo';
  static const String _nomeProduto = 'nome';
  static const String _valorProduto = 'valor';
  static const String _imagemProdutoBase64 = 'imagem';
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

  Future<List<Produto>> todosProdutos() async {

    final Database db = await getDB();
    final List<Map<String, dynamic>> resultado = await db.query(_tabela);

    List<Produto> produtos = _toList(resultado);

    return produtos;
  }

  List<Produto> _toList(List<Map<String, dynamic>> resultado) {
    // Converte o resultado da query SQL para uma Lista contendo produtos

    final List<Produto> produtos = [];

    for (Map<String, dynamic> linha in resultado){
      produtos.add(Produto(
          linha[_nomeProduto],
          linha[_qtd],
          linha[_valorProduto],
          linha[_imagemProdutoBase64]
      ));
    }
    return produtos;
  }

}