void main() {
  
    // dinamico todo
    Map persona = {
    	'nombre' : 'Carlos',
    	'edad' : 32,
    	'soltero' : true
    } 

    // llave en string y el valor dinamico
    Map<String, dynamic> persona = {
    	'nombre' : 'Carlos',
    	'edad' : 32,
    	'soltero' : true
    } 

	print(persona['nombre']); // printea carlos

	Map personas<int, String> {
		1 : 'Tony',
		2 : 'Peter',
		9 : 'Strange'
		'10' : 'Juan' // no permitido, porque las keys son int
	}

	// agregar un nuevo elemento
	personas.addall({4:'Banner'});

	// obtener peter
	print(personas[2]);

	
}