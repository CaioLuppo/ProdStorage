// Modelo para o produto


import 'dart:typed_data';

class Produto {
  // Variáveis
  final String nome;
  final int? quantidade;
  final double? valor;
  final Uint8List imagem;

  // Construtor
  Produto(
      this.nome,
      this.quantidade,
      this.valor,
      this.imagem,
      );
}
