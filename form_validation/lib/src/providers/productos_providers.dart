// hace las interacciones directas con la base de datos

import 'dart:convert';

import 'package:form_validation/src/models/producto_model.dart';
import 'package:http/http.dart' as http;

class ProductosProvider {
  final String _url = 'https://flutter-formvalidation.firebaseio.com';

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/productos.json';
    // se gasta ese metodo, de producto model to json, porque firebase necesita en formato string, no json
    final resp = await http.post(url, body: productoModelToJson(producto));
    final decodedData = json.decode(resp.body);

    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async {
    final url = '$_url/productos.json';
    final resp = await http.get(url);

    final Map<String,dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> productos = new List();

    if (decodedData == null) {
      return [];
    }

    decodedData.forEach((id, producto) {
      final productoTemp = ProductoModel.fromJson(producto);
      productoTemp.id = id;

      productos.add(productoTemp);
    });

    return productos;
  }

  Future<int> borrarProducto(String id) async {
    final url = '$_url/productos/$id.json';
    final resp = await http.delete(url);

    return 1;
  }

  Future<bool> editarProducto(ProductoModel producto) async {
    final url = '$_url/productos/${producto.id}.json';
    // se gasta ese metodo, de producto model to json, porque firebase necesita en formato string, no json
    final resp = await http.put(url, body: productoModelToJson(producto));
    final decodedData = json.decode(resp.body);

    return true;
  }

}