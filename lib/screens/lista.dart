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
    return Scaffold(

        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            title: const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text("Produtos", style: TextStyle(fontSize: 32)),
            ),
          ),
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
    return Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Card(
          child: ListTile(
            title: Padding(
                padding: const EdgeInsets.only(bottom: 8, top: 8),
                child: Text(_produto.nome.toString(), style: const TextStyle(fontSize: 24))
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                  "Qtd: ${_produto.quantidade.toString()} | Valor: ${_produto.valor.toString()}"),
            ),
          ),
        ),
    );
  }
}
