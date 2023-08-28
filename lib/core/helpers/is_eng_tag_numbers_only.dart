bool isEngTagNumbersOnly(String inputString) {
  // Use RegExp to match characters that are not in the set [a-zA-Z0-9@]
  RegExp nonAllowedCharacters = RegExp(r'[^a-zA-Z0-9@]');

  // Return true if there are no non-allowed characters in the input string
  return !nonAllowedCharacters.hasMatch(inputString);
}
