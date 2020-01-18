void main() {
	//saludar();
	String mensaje = salu('hola', 1);
	
	print(nombre());// error hay que decir el nombre de param
	print(nombre: 'fernando', texto: 'hola'); //da igual el orden, porque hara matching
}

// retorna valor dinamico
saludar() {
	print('hola');
}

// si no se pone el tipo infiere que es dinamico siempre
String salu(texto, nombre) {
	return '$texto $nombre'
}


// poner nombre a los argumentos
// si se ponen las llaves en los parametros, se debe especificar el nombre
String nombre({String texto, String nombre}) {
	return '$texto $nombre'
}

//funciones lambda
String nombre({String texto, String nombre}) => '$texto $nombre';
