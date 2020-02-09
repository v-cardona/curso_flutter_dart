import 'package:flutter/material.dart';
import 'package:form_validation/src/bloc/provider.dart';
import 'package:form_validation/src/providers/usuario_provider.dart';
import 'package:form_validation/src/utils/utils.dart' as utils;

class RegistroPage extends StatelessWidget {

  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(63, 63, 156, 1),
            Color.fromRGBO(90, 70, 178, 1)
          ],
        )
      ),
    );

    final circulo = Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned(
          child: circulo,
          top: 90,
          left: 30,
        ),
        Positioned(
          child: circulo,
          top: -40,
          right: -30,
        ),
        Positioned(
          child: circulo,
          bottom: -50,
          right: -10,
        ),
        Positioned(
          child: circulo,
          bottom: 120,
          right: 20,
        ),
        Positioned(
          child: circulo,
          bottom: -50,
          left: -20,
        ),
        Container(
          padding: EdgeInsets.only(top: 80),
          child: Column(
            children: <Widget>[
              Icon(Icons.person_pin_circle, color: Colors.white, size: 100,),
              SizedBox(height: 10,width: double.infinity,),
              Text('Fernando Herrera', style: TextStyle(color: Colors.white, fontSize: 25),)
            ],
          ),
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = Provider.of(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(height: 180,),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30),
            padding: EdgeInsets.symmetric(vertical: 50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3,
                  offset: Offset(0, 5),
                  spreadRadius: 3
                )
              ],
            ),
            child: Column(
              children: <Widget>[
                Text('Crear cuenta', style: TextStyle(fontSize: 20),),
                SizedBox(height: 60,),
                _crearEmail(bloc),
                SizedBox(height: 30,),
                _crearPassword(bloc),
                SizedBox(height: 60,),
                _crearBoton(bloc)
              ],
            ),
          ),
          FlatButton(
            onPressed: ()=> Navigator.pushReplacementNamed(context, 'login'),
            child: Text('¿Ya tienes cuenta? Login')),
          SizedBox(height: 100,)
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.emailStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.deepPurple,),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo Electronico',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: (value) {
              bloc.changeEmail(value);
            },
          ),
        );
      },
    );
  }
  
  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: Colors.deepPurple,),
              labelText: 'Contraseña',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: (value) {
              bloc.changePassword(value);
            },
          ),
        );  
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
            child: Text('Ingresar'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () { _register(bloc, context); } : null,
        );
      },
    );
  }

  _register(LoginBloc bloc, BuildContext context) async{
    final info = await usuarioProvider.nuevoUsuario(bloc.email, bloc.password);
    
    if (info['ok']) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      utils.mostrarAlerta(context, info['mensaje']);
    }
  }

}