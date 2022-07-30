// Dependências
import 'package:flutter/material.dart';
import 'package:formulario/database/dao/product_dao.dart';

// Criados
import 'formulario.dart';
import 'package:formulario/models/produto.dart';


class ListaProdutos extends StatefulWidget {
  final List<Produto> _produtos = [
    Produto("nome", 20, 1000, Image.asset('lib/assets/samples/ipad.png'))
  ];

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
                return ListView.builder(
                    itemCount: widget._produtos.length,
                    itemBuilder: (context, indx) {
                      final produto = widget._produtos[indx];
                      return ItemProduto(produto);
                    });

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
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 120,
                    width: 120,
                    child: _produto.imagem
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