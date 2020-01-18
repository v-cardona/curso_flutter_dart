void main() {
	
	// tipo dinamico
	List numeros = [1,2,3,4,5];
	
	numeros.add(6);
	print(numeros);

	// lo acepta porque son dinamicos
	numeros.add('Hola');

	// lista de enteros
	List<int> enteros = [1,2];
	numeros.add('Hola'); // da error de compilacion

	// tamaño fijo
	List masNumeros = List(10);
	masNumeros.add(1); // error de compilacion, por ser fijo, no puede crecer
	masNumeros[0] = 1;
}