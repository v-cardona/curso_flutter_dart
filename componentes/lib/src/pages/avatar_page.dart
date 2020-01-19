import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Avatar Page'),
          actions: <Widget>[
            Container(
              child: CircleAvatar(
                child: Text('SL'),
                backgroundColor: Colors.brown,
              ),
              margin: EdgeInsets.only(right: 10),
            ),
            Container(
              child: CircleAvatar(
                backgroundImage: NetworkImage('https://diablorock.com/wp-content/uploads/2018/11/stan-lee-768x506.jpg'),
              ),
              padding: EdgeInsets.all(5),
            )
          ],
        ),
        body: Center(
          child: FadeInImage(
            image: NetworkImage('http://img2.rtve.es/i/?w=1600&i=1539789456343.jpg'),
            placeholder: AssetImage('assets/jar_loading.gif'),
            fadeInDuration: Duration(milliseconds: 200),
          ),
        ),
      ),
    );
  }
}