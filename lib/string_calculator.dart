class StringCalculator {
  int add(String numbers) {
    if (numbers.isEmpty) return 0;
    if (numbers.contains(',')) {
      final parts = numbers.split(',');
      return parts.map(int.parse).reduce((a, b) => a + b);
    }
    return int.parse(numbers);
  }
}
