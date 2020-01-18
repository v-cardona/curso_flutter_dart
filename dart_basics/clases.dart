void main() {

	//new es opcional pero aconsejable
	//final wolverine siempre sera heroe, se podra cambiar los atributos de estos pero ya esta
	final wolverine = new Heroe({poder:'Regeneracion'});

	print(wolverine); //printea el toString
}

// definicion clase
// primera letra en mayuscula
class Heroe {

	//atributos
	String nombre;
	String poder;

	// constructor
	// establecer valor por defecto
/* 	Heroe({String nombre = 'sin nombre', String poder}) {
		this.nombre = nombre;
		this.poder = poder
	} */

  // constructor equivalente al de arrriba, a lo mejor sin lo de lo los param
  Heroe({this.nombre, this.poder});

  

// this es opcional
	String toString() {
		return '$nombre - ${this.poder}';
	}
}