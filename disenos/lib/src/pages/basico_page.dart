import 'package:flutter/material.dart';

class BasicoPage extends StatelessWidget {

  final estiloTitulo = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  final estiloSubtitulo = TextStyle(fontSize: 18, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _crearImagen(),
              _crearTitulo(),
              _crearAcciones(),
              _crearTexto(),
              _crearTexto(),
              _crearTexto(),
              _crearTexto(),
              _crearTexto(),
              _crearTexto(),
            ],
          ),
        )
      ),
    );
  }

  Widget _crearImagen() {
    return Container(
      width: double.infinity,
      child: Image(
        image: NetworkImage('https://images.pexels.com/photos/814499/pexels-photo-814499.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
        height: 180,
        fit: BoxFit.cover,
      ),
    );

  }

  Widget _crearTitulo() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Lago con un puente', style: estiloTitulo,),
                  SizedBox(height: 7,),
                  Text('un lago en alemania', style: estiloSubtitulo,)
                ],
              ),
            ),
            Icon(Icons.star, color: Colors.red, size: 30,),
            Text('41', style: TextStyle(fontSize: 20),)
          ],
        ),
      ),
    );
  }

  Widget _crearAcciones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _crearAccion(Icons.call, 'Call'),
        _crearAccion(Icons.near_me, 'Route'),
        _crearAccion(Icons.share, 'Share'),
      ],
    );
  }

  Widget _crearAccion(IconData icon, String texto) {
    return Column(
      children: <Widget>[
        Icon(icon, color: Colors.blue, size: 40,),
        SizedBox(height: 5,),
        Text(texto, style: TextStyle(fontSize: 15, color: Colors.blue),)
      ],
    );
  }

  Widget _crearTexto() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Text(
          'Fugiat voluptate pariatur eu aute Lorem Lorem duis quis qui. Et culpa in aute enim commodo nostrud nisi. Qui occaecat anim reprehenderit aliquip veniam velit. Amet pariatur ea cillum aute enim nulla deserunt. Deserunt in aute eu ut aute eiusmod pariatur eu cillum ullamco anim eiusmod laboris. Duis culpa consectetur reprehenderit non elit nostrud consectetur commodo commodo proident sint eu sunt proident.',
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

}