import 'package:flutter/material.dart';

import 'formulario.dart';
import 'package:formulario/models/produto.dart';

class ListaProdutos extends StatefulWidget {
  final List<Produto> _produtos = [];

  @override
  State<ListaProdutos> createState() => _ListaProdutosState();
}

class _ListaProdutosState extends State<ListaProdutos> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        appBar: AppBar(
          title: const Text("Produtos"),
        ),

        body: ListView.builder(
            itemCount: widget._produtos.length,
            itemBuilder: (context, indx) {
              final produto = widget._produtos[indx];
              return ItemProduto(produto);
            }),

        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          // Quando for pressionado, vai trocar pro formulário e atualizar
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Formulario();
              // Aqui o "produtoCriado" será o valor passado no "pop" do form
            })).then((produtoCriado) => _atualizaLista(produtoCriado));
          },
        ),
      ),
    );
  }

  // Função para atualizar a lista principal
  void _atualizaLista(Produto? produtoCriado){
    if(produtoCriado != null){
      setState(() {
        // O setState vai chamar novamente a build da lista, só que dessa vez
        // com a lista atualizada pelo comando abaixo.
        widget._produtos.add(produtoCriado);
      });
    }
  }

}


class ItemProduto extends StatelessWidget {
  // Guarda o padrão para o item
  final Produto _produto;

  ItemProduto(this._produto);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("Produto: ${_produto.nome}"),
        subtitle: Text(
            "Qtd: ${_produto.quantidade.toString()} | Valor: ${_produto.valor.toString()}"),
      ),
    );
  }
}
