String removeNonEnglishLetters(String input) {
  RegExp englishLetters = RegExp(r'[A-Za-z]');
  List<String?> englishMatches =
      englishLetters.allMatches(input).map((match) => match.group(0)).toList();
  return englishMatches.join();
}
