class StringCalculator {
  int _callCount = 0;

  int getCalledCount() => _callCount;

  int add(String numbers) {
    _callCount++;
    if (numbers.isEmpty) return 0;

    final content = _extractContent(numbers);
    final delimiterPattern = _extractDelimiterPattern(numbers);

    final values = _parseNumbers(content, delimiterPattern);
    _checkForNegatives(values);

    return _sum(values);
  }

  String _extractContent(String numbers) {
    if (numbers.startsWith('//')) {
      return numbers.substring(numbers.indexOf('\n') + 1);
    }
    return numbers;
  }

  String _extractDelimiterPattern(String numbers) {
    if (!numbers.startsWith('//')) return '[,\n]';

    final delimiterSpec = numbers.substring(2, numbers.indexOf('\n'));

    // Extract all delimiters inside [ ]
    final matches = RegExp(r'\[(.+?)\]').allMatches(delimiterSpec);

    if (matches.isNotEmpty) {
      return matches
          .map((m) => RegExp.escape(m.group(1)!))
          .join('|'); // OR pattern
    }

    // Single-character delimiter fallback
    return RegExp.escape(delimiterSpec);
  }

  List<int> _parseNumbers(String content, String pattern) {
    return content
        .split(RegExp(pattern))
        .where((s) => s.isNotEmpty)
        .map(int.parse)
        .toList();
  }

  void _checkForNegatives(List<int> numbers) {
    final negatives = numbers.where((n) => n < 0).toList();
    if (negatives.isNotEmpty) {
      throw Exception("negatives not allowed: ${negatives.join(', ')}");
    }
  }

  int _sum(List<int> numbers) {
    return numbers.where((v) => v <= 1000).fold(0, (a, b) => a + b);
  }
}
