import 'package:intl/intl.dart';

final currencyFormatter = new NumberFormat("#,###");
final idrFormatter = new NumberFormat("Rp #,###");

extension ExtendedNum on num {
  String currencyFormat() => currencyFormatter.format(this);
  String idrFormat() => idrFormatter.format(this);
  String toPercentageString() => (this * 100).toInt().toString() + " %";
}
