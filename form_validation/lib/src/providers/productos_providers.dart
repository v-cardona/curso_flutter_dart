// hace las interacciones directas con la base de datos

import 'dart:convert';

import 'package:form_validation/src/models/producto_model.dart';
import 'package:form_validation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

class ProductosProvider {
  final String _url = 'https://flutter-formvalidation.firebaseio.com';
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/productos.json';
    // se gasta ese metodo, de producto model to json, porque firebase necesita en formato string, no json
    final resp = await http.post(url, body: productoModelToJson(producto));
    final decodedData = json.decode(resp.body);

    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async {
    final url = '$_url/productos.json?auth=${_prefs.token}';
    final resp = await http.get(url);

    final Map<String,dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> productos = new List();

    if (decodedData == null) {
      return [];
    }

    // esto por si expira el tokenid, muestra nada, pero aqui seria donde se manda o hace lo que quiera
    if (decodedData['error'] != null) {
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
    final url = '$_url/productos/$id.json?auth=${_prefs.token}';
    final resp = await http.delete(url);

    return 1;
  }

  Future<bool> editarProducto(ProductoModel producto) async {
    final url = '$_url/productos/${producto.id}.json?auth=${_prefs.token}';
    // se gasta ese metodo, de producto model to json, porque firebase necesita en formato string, no json
    final resp = await http.put(url, body: productoModelToJson(producto));
    final decodedData = json.decode(resp.body);

    return true;
  }

  Future<String> subirImagen (File imagen) async{
     final url = Uri.parse('https://api.cloudinary.com/v1_1/de0ji7bxm/image/upload?upload_preset=ghmc3t7s');
     final mimeType = mime(imagen.path).split('/');

     final imageUploadRequest = http.MultipartRequest(
       'POST',
       url
     ); 

     final file = await http.MultipartFile.fromPath(
        'file',
        imagen.path,
        contentType: MediaType(
          mimeType[0],
          mimeType[1]
        )
    );

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      return null;
    }

    final respData = json.decode(resp.body);
    return respData['secure_url'];

  }

}