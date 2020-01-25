import 'package:flutter/material.dart';
import 'package:form_validation/src/models/producto_model.dart';
import 'package:form_validation/src/providers/productos_providers.dart';
import 'package:form_validation/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {
  // para controlar el formulario y poder validarlo
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProductoModel producto = new ProductoModel();
  final productoProvider = new ProductosProvider();

  //para no pulsar el boton varias veces mientras aun esta guardando
  bool _guardando = false;

  @override
  Widget build(BuildContext context) {

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
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {},
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

  void _submit() {
    if (!formKey.currentState.validate()) {
      return;
    }
    // instruccion para ejecutar el onSaved de lod forms
    formKey.currentState.save();
    
    //para no pulsar el boton varias veces mientras aun esta guardando
    _guardando = true;
    setState(() {});

    if (producto.id == null) {
      productoProvider.crearProducto(producto);
    } else {
      productoProvider.editarProducto(producto);
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
}