import 'package:flutter/material.dart';
import 'package:form_validation/src/bloc/provider.dart';
import 'package:form_validation/src/models/producto_model.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final productosBloc = Provider.productosBloc(context);
    productosBloc.cargarProductos();
    
    
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage')
      ),
      //para la app original de formValidation
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: <Widget>[
      //     Text('Email: ${bloc.email}'),
      //     Divider(),
      //     Text('Password: ${bloc.password}'),
      //   ],
      // ),
      body: _crearListado(productosBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.pushNamed(context, 'producto');
      },
      backgroundColor: Theme.of(context).primaryColor,
    );  
  }

  Widget _crearListado(ProductosBloc productosBloc) {

    return StreamBuilder(
      stream: productosBloc.productosStream,
      builder:(BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, index) {
              return _crearItem(context, productosBloc ,productos[index]);
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );


  }

  Widget _crearItem(BuildContext context, ProductosBloc productosBloc, ProductoModel producto) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        productosBloc.borrarProducto(producto.id);
      },
      child: Card(
        child: Column(
          children: <Widget>[

            (producto.fotoUrl == null)
             ? Image(image: AssetImage('assets/no-image.png'))
             : FadeInImage(
              placeholder: AssetImage('assets/jar-loading.gif'),
              image: NetworkImage(producto.fotoUrl),
              height: 30,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            ListTile(
              title: Text(producto.titulo + ' - ' + producto.valor.toString()),
              subtitle: Text(producto.id),
              onTap: () {
                Navigator.pushNamed(context, 'producto', arguments: producto);
              },
            ),
          ],
        ),
      )
    );
  }
}
