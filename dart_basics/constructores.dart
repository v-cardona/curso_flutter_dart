// para transformar json
import 'dart:convert';

void main() {
    //final wolverine = new Heroe('Logan', 'regeneracion');
    
    // ejemplo como si fuera una respuesta de api
    final rawJson = '{"nombre":"Logan", "poder": "regeneracion"}';

    Map parsedJson = json.decode(rawJson);

    
    // diccionario dinamico del json 
    print(parsedJson);
    
    final wolverine = new Heroe.fromJson(parsedJson);
}

class Heroe() {
    String nombre;
    String poder;

    Heroe(this.nombre, this.poder);

    //constructor que reciba diccionario y crea heroe
    // constructor con nombre
    Heroe.fromJson(Map parsedJson) {
        nombre = parsedJson['nombre'];
        poder = parsedJson['poder'];
    }
}