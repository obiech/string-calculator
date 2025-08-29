import 'package:flutter/material.dart';

class Keys {
  const Keys();

  static const Key textField = Key("stringCalculatorTextField");
  static const Key calculateButton = Key("stringCalculateButton");
  static const Key calculationResultText = Key("stringCalculationResultText");

  static Key keyboardButton(String value) => Key("keyboardButton_$value");
}
