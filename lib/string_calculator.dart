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

    final parts = content
        .split(RegExp(delimiterPattern))
        .where((s) => s.isNotEmpty)
        .toList();
    final values = parts.map(int.parse).toList();

    final negatives = values.where((v) => v < 0).toList();
    if (negatives.isNotEmpty) {
      throw Exception("negatives not allowed: ${negatives.join(', ')}");
    }

    return values.fold(0, (a, b) => a + b);
  }
}
