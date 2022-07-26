// Modelo para o produto

class Produto {
  // Variáveis
  final String nome;
  final int? quantidade;
  final double? valor;

  // Construtor
  Produto(
      this.nome,
      this.quantidade,
      this.valor,
      );

  @override  // Reescreve o método toString na classe
  String toString() {
    return 'Produto{nome: $nome, quantidade: $quantidade, valor: $valor}';
  }
}
