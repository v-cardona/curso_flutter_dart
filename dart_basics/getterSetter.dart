void main() {
	final cuadrado = new Cuadrado();

	cuadrado.lado = 10;

	print(cuadrado);
	print('area = $(cuadrado.area)');

}

class Cuadrado {
	
	// hacerla privada con guion bajo
	double _lado;
	//double _area;

	set lado(double valor) {
		// comprobar y lanzar error
		if ( valor <= 0) {
			throw('lado no puede ser <= a 0')
		}

		_lado = valor;
	}

	// no lleva parentesis de argumentos
/* 	double get area {
		return _lado * _lado;
	} */
	double get area => _lado * _lado; // funcion lambda equivalente

	toString() => 'Lado: $_lado';
}