// atributo ortogonal a las clases finales que heredan
// https://medium.com/flutter-community/dart-what-are-mixins-3a72344011f3

abstract class Animal {

}

//caracteristicas
abstract class Mamifero extends Animal { }

abstract class Ave extends Animal { }

abstract class Pez extends Animal { }

// cosas que pueden hacer
abstract class Volador {
	void volar() => print('estoy volando');
}

abstract class Caminante {
	void caminar() => print('estoy caminando');
}

abstract class Nadador {
	void nadar() => print('estoy nadando');
}


// el with es para el mixin de nadador
class Delfin extends Mamifero with Nadador {

}

class Murcielago extends Mamifero with Caminante, Volador {

}

class Gato extends Mamifero with Caminante {}

class Paloma extends Ave with Volador, Caminante {}

class Pato extends Ave with Volador,Caminante,Nadador {}

class Tiburon extends Pez with Nadador {}

class PezVolador extends Pez with Nadador, Volador {}


void main() {
	final pato = new Pato();
	pato.volar();

	final pezV = new PezVolador();
	pezV.nadar();
	pezV.volar();
}