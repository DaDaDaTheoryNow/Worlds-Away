String removeAllWithoutEnglishLettersAndNumbers(String input) {
  RegExp englishLettersAndDigits = RegExp(r'[A-Za-z0-9]');
  List<String?> matches = englishLettersAndDigits
      .allMatches(input)
      .map((match) => match.group(0))
      .toList();
  return matches.join();
}
