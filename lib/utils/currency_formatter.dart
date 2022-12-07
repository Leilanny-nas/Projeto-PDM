import 'package:intl/intl.dart';

String formatCurrency(double value) {
  NumberFormat f =
      NumberFormat.currency(locale: "pt_BR", name: "R\$", decimalDigits: 2);
  return f.format(value);
}
