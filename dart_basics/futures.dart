void main() {

	print('antes de pedir datos');
	httpGet('https://api.com').then((data) {
		print(data);
	});

	// se pintara este linea antes que el hola mundo, porque es asincrono
	
	print('ultima linea');

}

// son como las promesas en js
// avisa cuando a terminado el proceso, tarea asincrona, hilo independiente
// se lanza y se continua

// asincrono que devuelve sting
// se gasta para simularlo en el ejemplo, si se lee todo no tiene sentido
// esta simulando una peticion la cual si que devuelve un future, de manera asincrona
Future<String> httpGet(String url) {
	//funcion callback
	return Future.delayed(new Duration(seconds: 4), () {
		return 'hola mundo'
	});
}

void main() async {

	print('antes de pedir datos');

	// await solo funciona con funcion async
	// constructores no pueden ser asincronos
	String data = await httpGet('https://api.com');

	print(data);
	// se pintara este linea antes que el hola mundo, porque es asincrono

	// se puede evitar con el await
	// se espera hasta que se resuelva la asincrona
	print('ultima linea');

}