import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Currencyformat extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    double value = double.parse(newValue.text);
    final money = new NumberFormat("###,###,###", "pt-br");

    String newText = money.format(value);
    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(
          offset: 2,
        ));
  }
}
