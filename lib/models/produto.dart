// Modelo para o produto

import 'package:flutter/cupertino.dart';

class Produto {
  // Variáveis
  final String nome;
  final int? quantidade;
  final double? valor;
  final Image imagem;

  // Construtor
  Produto(
      this.nome,
      this.quantidade,
      this.valor,
      this.imagem,
      );
}
