import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Peliculas en cines'),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              _swipeTarjetas()
            ],
          ),
        )
      ),
    );
  }

  Widget _swipeTarjetas() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      width: double.infinity,
      height: 300,
      child: new Swiper(
        itemWidth: 200,
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/Pac-Man_Cutscene.svg/283px-Pac-Man_Cutscene.svg.png",
            fit: BoxFit.fill,
          );
        },
        itemCount: 3,
        pagination: SwiperPagination(),
        control: SwiperControl(),
        layout: SwiperLayout.STACK,
      )
    );
  }

}