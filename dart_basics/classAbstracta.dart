
void main() {
	final perro = new Animal(); // error de compilacion, por ser clase abstracta
	perro.emitirSonido();
}

abstract class Animal {
	
	int patas;

	void emitirSonido();
}

// debe cumplir lo que hay en la clase abstracta
class Perro implements Animal{
	
	int patas;
	int colas;

	void emitirSonido() => print('guau');
}


class Gato implements Animal{
	
	int patas;
	int colas;

	void emitirSonido() => print('miau');
}