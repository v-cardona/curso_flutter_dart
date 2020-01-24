import 'package:flutter/material.dart';
import 'package:form_validation/src/bloc/login_bloc.dart';
export 'package:form_validation/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget{

  final login = LoginBloc();

  Provider({Key key, Widget child})
    : super(key: key, child: child);

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
