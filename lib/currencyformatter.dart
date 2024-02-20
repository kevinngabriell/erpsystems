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
    // Use NumberFormat to format the input with commas
    final format = NumberFormat.decimalPattern();

    String newText = format.format(double.parse(newValue.text.replaceAll(",", "")));

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
