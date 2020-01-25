
bool isNumeric(String valor) {
  if (valor.isEmpty) {
    return false;
  }
  final number = num.tryParse(valor);
  return number != null;
}