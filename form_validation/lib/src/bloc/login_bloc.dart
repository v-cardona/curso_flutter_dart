import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:form_validation/src/bloc/validators.dart';


class LoginBloc with Validators {

  //se cambian los stream controllers porque la libreria para combinarlos no trabaja con ellos
  // final StreamController _emailController = StreamController<String>.broadcast();
  // final StreamController _passwordController = StreamController<String>.broadcast();

  final  _emailController = BehaviorSubject<String>();
  final  _passwordController = BehaviorSubject<String>();

  Stream<bool> get formValidStream {
    return Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);
  }

  // recuperar datos del stream
  Stream<String> get emailStream {
    return _emailController.stream.transform(validarEmail);
  }

  Stream<String> get passwordStream {
    return _passwordController.stream.transform(validarPassword);
  }


  // getters y settes
  Function(String) get changeEmail {
    return _emailController.sink.add;
  }

  Function(String) get changePassword {
    return _passwordController.sink.add;
  }

  // obtener el ultima valor ingresado a los streams
  String get email {
    return _emailController.value;
  }
  String get password {
    return _passwordController.value;
  }

  // cerrar los stream
  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }


}

