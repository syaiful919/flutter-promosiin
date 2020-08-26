import 'package:date_format/date_format.dart';

extension ExtendedDateTime on DateTime {
  String format() =>
      formatDate(this, [dd, ' ', M, ' ', yyyy, ' | ', HH, ':', nn, ':', ss]);

  String getDateOnly() => formatDate(this, [dd, ' ', M, ' ', yyyy]);

  int diffInSecond() => this.difference(DateTime.now()).inSeconds;
}
