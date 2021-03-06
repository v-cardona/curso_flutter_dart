import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_validation/src/bloc/provider.dart';
import 'package:form_validation/src/models/producto_model.dart';
import 'package:form_validation/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductoPage extends StatefulWidget {
  // para controlar el formulario y poder validarlo
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  ProductosBloc productosBloc;
  ProductoModel producto = new ProductoModel();
  File foto;

  //para no pulsar el boton varias veces mientras aun esta guardando
  bool _guardando = false;

  @override
  Widget build(BuildContext context) {

    productosBloc = Provider.productosBloc(context);
    
    // recibe los argumentos y comprueba si hay algo o no, si no hay gasta la creacion de arriba, sino lo que recibe
    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      producto = prodData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBoton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto',
      ),
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
      //se lanza cuando se ha validado
      onSaved: (value) {
        producto.titulo = value;
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio',
      ),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
      //se lanza cuando se ha validado
      onSaved: (value) {
        producto.valor = double.parse(value);
      },
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      icon: Icon(Icons.save),
      label: Text('Guardar'),
      onPressed: (_guardando) ? null : _submit,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) {
      return;
    }
    // instruccion para ejecutar el onSaved de lod forms
    formKey.currentState.save();
    
    //para no pulsar el boton varias veces mientras aun esta guardando
    _guardando = true;
    setState(() {});

    if (foto != null) {
      producto.fotoUrl = await productosBloc.subirFoto(foto);
    }

    if (producto.id == null) {
      productosBloc.agregarProducto(producto);
    } else {
      productosBloc.editarProducto(producto);
    }
    
    // no es necesario aqui porque se va a la pantalla anterior
    // _guardando = false;
    // setState(() {});

    mostrarSnackbar('Registro guardado');

    Navigator.pop(context);
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: producto.disponible,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) {
        setState(() {
        });
        producto.disponible = value;
      },
    );

  }

  void mostrarSnackbar(String mensaje) {
    final snackBar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    // el scafol es quien puede emitir el snackbar, por eso hay que llamarlo
    scaffoldKey.currentState.showSnackBar(snackBar);
  }



  Widget _mostrarFoto() {
    if (producto.fotoUrl != null) {
      return FadeInImage(
        placeholder: AssetImage('assets/jar-loading.gif'),
        image: NetworkImage(producto.fotoUrl),
        height: 300,
        fit: BoxFit.contain,
      );
    } else {
      return Image(
        // si la foto tiene valor, con el ?, y toma el path, si es nulo entonces coge el assets
        image: AssetImage( foto?.path ?? 'assets/no-image.png'),
        height: 300,
        fit: BoxFit.cover,
      );
    }
  }

  void _seleccionarFoto() async{
    _procesarImagen(ImageSource.gallery);
  }

  void _tomarFoto() async{
    _procesarImagen(ImageSource.camera);
  }


  _procesarImagen(ImageSource origen) async{
    foto = await ImagePicker.pickImage(
      source: origen,
    );

    if (foto != null) {
      producto.fotoUrl = null;
    }
    setState(() {});

  }
}