bool isNonRussianOnly(String inputString) {
  // Use RegExp to match any Russian letters (Cyrillic characters)
  RegExp russianLetters = RegExp(r'[а-яА-Я]');

  // Return true if there are no Russian letters in the input string
  return !russianLetters.hasMatch(inputString);
}
