import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cards'),
        ),
        body: ListView(
          children: <Widget>[
            _cardTipo1(),
            SizedBox(height: 30,),
            _cardTipo2(),
            SizedBox(height: 30,),
            _cardTipo1(),
            SizedBox(height: 30,),
            _cardTipo2(),
            SizedBox(height: 30,),
          ],
          padding: EdgeInsets.all(10),
        ),
      ),
    );
  }

  Widget _cardTipo1() {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.photo_album, color:  Colors.blue,),
            title: Text('Titulo'),
            subtitle: Text('subtitulo de la tarjeta, texto demasiado largo para ver lo que va a pasar'),
          ),
          Row(
            children: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {},
              ),
              FlatButton(
                child: Text('OK'),
                onPressed: () {},
              )
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          )
        ],
      ),
    ); 
  }

  Widget _cardTipo2() {
    final card = Container(
      //evita que lo de dentro se salga de la tarjeta
      //clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          //permite hacer que carga mientras llega la imagen
          FadeInImage(
            image: NetworkImage('https://www.tom-archer.com/wp-content/uploads/2018/06/milford-sound-night-fine-art-photography-new-zealand.jpg'),
            placeholder: AssetImage('assets/jar_loading.gif'),
            fadeInDuration: Duration(milliseconds: 200),
            height: 300,
            fit: BoxFit.cover,
          ),
          // Image(
          //   image: NetworkImage('https://www.tom-archer.com/wp-content/uploads/2018/06/milford-sound-night-fine-art-photography-new-zealand.jpg'),
          // ),
          Container(
            child: Text('No tengo idea de que poner'),
            padding: EdgeInsets.all(10),
          )
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(2, 10)
          )
        ]
      ),
      child: ClipRRect(
        child: card,
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}