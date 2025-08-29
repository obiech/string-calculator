class StringCalculator {
  int add(String numbers) {
    if (numbers.isEmpty) return 0;
    String delimiterPattern = '[,\n]';
    String content = numbers;

    if (numbers.startsWith('//')) {
      final delimiter = numbers[2];
      delimiterPattern = '[$delimiter]';
      content = numbers.substring(4); // skip `//x\n`
    }

    final parts = content.split(RegExp(delimiterPattern));
    return parts.map(int.parse).reduce((a, b) => a + b);
  }
}
