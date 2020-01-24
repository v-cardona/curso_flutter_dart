import 'package:flutter/material.dart';
import 'package:form_validation/src/bloc/login_bloc.dart';
export 'package:form_validation/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget{

  static Provider _instancia;
  
  // si se regresa una nueva instancia o la actual
  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child,);
    }
    return _instancia;
  }

  Provider._internal({Key key, Widget child})
    : super(key: key, child: child);

  final login = LoginBloc();


  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  // retornar la instancia del bloc en el contexto, el arbol de widgets
  static LoginBloc of(BuildContext context) {
    // esta solucion esta deprecated
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).login;
  } 


}
