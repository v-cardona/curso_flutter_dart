import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  String _nombre = '';
  String _email = '';
  String _fecha = '';
  String _opcionSeleccionada = 'volar';
  TextEditingController _inputFieldDateController = TextEditingController();
  List<String> _poderes = ['volar', 'rayosX', 'superAliento', 'superFuerza'];
 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inputs de texto'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: <Widget>[
          _crearInput(),
          Divider(),
          _crearEmail(),
          Divider(),
          _crearPassword(),
          Divider(),
          _crearFecha(context),
          Divider(),
          _crearDropdown(),
          Divider(),
          _crearPersona()
        ],
      ),
    );
  }

  Widget _crearInput() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        counter: Text('Letras ' + _nombre.length.toString()),
        hintText: 'Nombre de la persona',
        labelText: 'Nombre',
        helperText: 'solo es el nombre',
        suffixIcon: Icon(Icons.accessible),
        icon: Icon(Icons.account_circle)
      ),
      onChanged: (valor) {
        setState(() {
          
        });
        _nombre = valor;
      },
    );
  }

  Widget _crearPersona() {
    return ListTile(
      title: Text('Nombre es: $_nombre'),
      subtitle: Text('Email es: $_email'),
      trailing: Text(_opcionSeleccionada),
    );
  }

  Widget _crearEmail() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        hintText: 'Email',
        labelText: 'Email',
        suffixIcon: Icon(Icons.alternate_email),
        icon: Icon(Icons.email)
      ),
      onChanged: (valor) {
        setState(() {
          
        });
        _email = valor;
      },
    );

  }

  Widget _crearPassword() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        hintText: 'Password',
        labelText: 'Password',
        suffixIcon: Icon(Icons.lock_open),
        icon: Icon(Icons.lock)
      ),
      onChanged: (valor) {
        setState(() {
          
        });
        _email = valor;
      },
    );
  }

  Widget _crearFecha(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false,
      controller: _inputFieldDateController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        hintText: 'Fecha de Nacimiento',
        labelText: 'fecha de nacimiento',
        suffixIcon: Icon(Icons.perm_contact_calendar),
        icon: Icon(Icons.calendar_today)
      ),
      //lanzar el selector de la fecha
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );

  }

  Future _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2018),
      initialDate: DateTime.now(),
      lastDate: DateTime(2025),
      locale: Locale('es', 'ES')
    );
    if (picked != null) {
      setState(() {
      });
      _fecha = picked.toString();
      _inputFieldDateController.text = _fecha;
    }
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown() {

    List<DropdownMenuItem<String>> lista = new List();
    _poderes.forEach((poder) {
      lista.add(DropdownMenuItem(
        child: Text(poder),
        value: poder,
      ));
    });
    return lista; 
  }

  Widget _crearDropdown() {

    return Row(
      children: <Widget>[
        Icon(Icons.select_all),
        SizedBox(width: 30,),
        Expanded(
          child: DropdownButton(
            value: _opcionSeleccionada,
            items: getOpcionesDropdown(),
            onChanged: (opt) {
              _opcionSeleccionada = opt;
              setState(() {
                
              });
            },
          ),
        )
      ],
    );
  }
}