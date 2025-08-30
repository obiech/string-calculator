import 'package:flutter/material.dart';
import 'package:kata_calculator/features/string_calculator/presentation/string_calculator_keys.dart';
import 'package:kata_calculator/features/string_calculator/utils/constants.dart';
import 'package:kata_calculator/string_calculator.dart';

class StringCalculatorScreen extends StatefulWidget {
  const StringCalculatorScreen({super.key});

  @override
  State<StringCalculatorScreen> createState() => _StringCalculatorScreenState();
}

class _StringCalculatorScreenState extends State<StringCalculatorScreen> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _customDelimiterController =
      TextEditingController();
  final FocusNode _focusNode = FocusNode();

  String _outputValue = "";

  List<String> get _keyboardText => [
    ...Consts.keyboardText,
    _customDelimiterController.text,
  ];

  void _onCalculate() {
    try {
      final calculator = StringCalculator();

      final delimiterPrefix = _customDelimiterController.text.isEmpty
          ? ''
          : '//${_customDelimiterController.text}\n';

      final result = calculator.add(
        '$delimiterPrefix${_inputController.text.trim()}',
      );

      setState(() => _outputValue = 'Result: $result');
    } catch (e) {
      setState(() => _outputValue = e.toString());
    }
  }

  void _keyboardInput(String value) {
    if (value == 'clear') {
      _inputController.clear();
      return;
    }

    final text = _inputController.text;
    final selection = _inputController.selection;

    if (!_focusNode.hasFocus) {
      _focusNode.requestFocus();
    }

    final newText = text.replaceRange(selection.start, selection.end, value);

    _inputController.value = _inputController.value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(
        offset: selection.start + value.length,
      ),
      composing: TextRange.empty,
    );
  }

  @override
  void initState() {
    super.initState();
    _customDelimiterController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _inputController.dispose();
    _customDelimiterController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kata Calculator'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 22),
            CalculatorInputField(
              textFieldKey: Keys.demiliterTextField,
              controller: _customDelimiterController,
              label: "Custom delimiter",
            ),
            const SizedBox(height: 22),
            CalculatorInputField(
              textFieldKey: Keys.textField,
              controller: _inputController,
              focusNode: _focusNode,
              label: 'Enter numbers e.g. 1, 2, 3',
            ),
            const SizedBox(height: 12),
            Wrap(
              children: _keyboardText
                  .map(
                    (d) => KeyboardButton(
                      value: d,
                      onTap: () => _keyboardInput(d),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 22),
            CalculateButton(onPressed: _onCalculate),
            const SizedBox(height: 22),
            ResultDisplay(value: _outputValue),
          ],
        ),
      ),
    );
  }
}

/// Input Field
class CalculatorInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String label;
  final Key textFieldKey;

  const CalculatorInputField({
    super.key,
    required this.controller,
    this.focusNode,
    required this.label,
    required this.textFieldKey,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: textFieldKey,
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      minLines: 1,

      textAlign: TextAlign.center,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        hintText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}

/// Result display
class ResultDisplay extends StatelessWidget {
  final String value;
  const ResultDisplay({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      key: Keys.calculationResultText,
      value,
      style: Theme.of(context).textTheme.headlineLarge,
      textAlign: TextAlign.center,
    );
  }
}

/// Calculate button
class CalculateButton extends StatelessWidget {
  final VoidCallback onPressed;
  const CalculateButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: Keys.calculateButton,
      onPressed: onPressed,
      child: const Text("Calculate"),
    );
  }
}

/// KeyboardButton button
class KeyboardButton extends StatelessWidget {
  final String value;
  final VoidCallback onTap;

  const KeyboardButton({super.key, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: Keys.keyboardButton(value),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: OutlinedButton(
        onPressed: onTap,
        child: Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
    );
  }
}
