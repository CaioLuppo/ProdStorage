// SQLite
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// DAO
import './dao/product_dao.dart';


Future<Database> getDB() async {

  // Criação do caminho da database
  final String path = join(await getDatabasesPath(), "inventario.db");

  // Comunicação e criação do banco de dados
  return openDatabase(
    path,  // Passa o caminho do banco, depois as propriedades que quer mexer

    onCreate: (
        inventario,  // Banco
        version,  // Versão
        ) {
      inventario.execute(ProductDao.createTable);
    },

    version: 1,  // Versão do banco que está utilizando
  );
}