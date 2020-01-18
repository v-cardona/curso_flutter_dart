void main() {
  bool activado = true;
  print(activado);

  activado = !activado; // not

  if (activado) {
    print("encendido");
  } else {
    print("apagado");
  }
}