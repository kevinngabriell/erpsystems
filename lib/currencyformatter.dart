import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove non-digits and "Rp" prefix
    final cleanedText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleanedText.isEmpty) {
      return newValue;
    }

    final number = int.parse(cleanedText);
    final formattedValue = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
        .format(number);

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.fromPosition(TextPosition(offset: formattedValue.length)),
    );
  }
}

class CurrencyFormatterUSD extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(
      text: _formatCurrency(newValue.text),
      selection: updateCursorPosition(newValue, offset: 3), // Change the offset as needed
    );
  }

  String _formatCurrency(String input) {
    final cleanedText = input.replaceAll(RegExp(r'[^0-9.]'), '');

    if (cleanedText.isEmpty) {
      return '';
    }

    final number = double.parse(cleanedText);
    final formattedValue = NumberFormat.currency(locale: 'en_US', symbol: 'USD ', decimalDigits: 2)
        .format(number);

    return formattedValue;
  }

  TextSelection updateCursorPosition(TextEditingValue value, {required int offset}) {
    final newOffset = value.text.length - offset;
    return TextSelection.fromPosition(TextPosition(offset: newOffset));
  }
}


class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Extract the numeric part of the input (removing commas, symbols, etc.)
    String numericText = newValue.text.replaceAll(RegExp(r'[^\d.]'), '');

    // Parse the input value to double, handling empty string as well
    double value = double.tryParse(numericText) ?? 0.0;

    // Format the double value as currency without the symbol
    String formattedText = NumberFormat.currency(locale: 'en_US', decimalDigits: 2, symbol: '').format(value);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length + 2),
    );
  }
}


class CurrencyFormatterNoCurrency extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove non-digits and "Rp" prefix
    final cleanedText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleanedText.isEmpty) {
      return newValue;
    }

    final number = int.parse(cleanedText);
    final formattedValue = NumberFormat.currency(decimalDigits: 2)
        .format(number);

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.fromPosition(TextPosition(offset: formattedValue.length)),
    );
  }
}