import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  

  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {

  double _valorSlider = 100;
  bool _bloquearCheck = false;

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         appBar: AppBar(
           title: Text('Sliders'),
         ),
         body: Container(
           padding: EdgeInsets.only(top: 50),
           child: Column(
             children: <Widget>[
              _crearSlider(),
              _crearCheckbox(),
              _crearSwitch(),
              Expanded(
                child: _crearImagen()
              ),
             ],
           ),
         ),
       ),
    );
  }

  Widget _crearSlider() {
    return Slider(
      activeColor: Colors.indigoAccent,
      label: 'Tamaño de la imagen',
      divisions: 20,
      onChanged: (_bloquearCheck ? null : (valor) {
        _valorSlider = valor;
        setState(() {
          
        });
      }),
      value: _valorSlider,
      min: 10,
      max: 400,
    );
  }

  Widget _crearImagen() {
    return Image(
      image: NetworkImage('https://www.camaracivica.com/wp-content/uploads/2016/07/2108594.jpg'),
      width: _valorSlider,
      fit: BoxFit.contain,
    );
  }

  Widget _crearCheckbox() {
    // return Checkbox(
    //   value: _bloquearCheck,
    //   onChanged: (valor) {
    //     _bloquearCheck = valor;
    //     setState(() {
          
    //     });
    //   },
    // );

    return CheckboxListTile(
      value: _bloquearCheck,
      onChanged: (valor) {
        _bloquearCheck = valor;
        setState(() {
          
        });
      },
      title: Text('Bloquear Slider'),
    );
  }

  Widget _crearSwitch() {

    return SwitchListTile(
      value: _bloquearCheck,
      onChanged: (valor) {
        _bloquearCheck = valor;
        setState(() {
          
        });
      },
      title: Text('Bloquear Slider'),
    );
  }
}