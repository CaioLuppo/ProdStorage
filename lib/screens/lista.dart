// Dependências
import 'package:flutter/material.dart';
import 'package:prod_storage/database/dao/product_dao.dart';

// Criados
import 'formulario.dart';
import 'package:prod_storage/models/produto.dart';


class ListaProdutos extends StatefulWidget {
  @override
  State<ListaProdutos> createState() => _ListaProdutosState();
}

class _ListaProdutosState extends State<ListaProdutos> {
  final ProductDao _dao = ProductDao();

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

        body: FutureBuilder<List<Produto>>(
          future: _dao.todosProdutos(),
          builder: (context, snapshot) {

            switch(snapshot.connectionState){

              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      Text("Carregando produtos...")
                    ],
                  ),
                );

              case ConnectionState.done:
                final List<Produto> produtos = snapshot.data!;
                if (produtos.isNotEmpty) {
                  return ListView.builder(
                      itemCount: produtos.length,
                      itemBuilder: (context, indx) {
                        final produto = produtos[indx];
                        return ItemProduto(produto);
                      });
                } else {
                  return const Center(
                    child: Text("Nenhum produto no inventário."),
                  );
                }

              case ConnectionState.none:
                return const Text("Erro desconhecido");
              case ConnectionState.active:
                return const Text("Erro desconhecido");

            }
          },
        ),

        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          // Quando for pressionado, vai trocar pro formulário e atualizar
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Formulario();
              // Aqui o "produtoCriado" será o valor passado no "pop" do form
            })).then((value) => setState((){}));
          },
        ),
    );
  }
}

class ItemProduto extends StatelessWidget {

  // Guarda o padrão para o item
  final Produto _produto;

  ItemProduto(this._produto);

  // imagem, nome, quantidade e valor
  @override
  Widget build(BuildContext context) {

    final valor = _produto.valor?.toStringAsFixed(2);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).hoverColor
        ),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: decodificaImagem(_produto.imagem),
                    ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        _produto.nome,
                        style: const TextStyle(fontSize: 27),
                      ),
                    ),
                    Text('Em estoque: ${_produto.quantidade}'),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text('Valor: R\$ $valor'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
    );
  }
}