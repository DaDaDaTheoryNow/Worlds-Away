bool isLatinOnly(String inputString) {
  return RegExp(r'^[a-zA-Z\s]+$').hasMatch(inputString);
}
