import 'dart:convert';

extension ExtendedList on List {
  String toJson() => json.encode(List.from(this.map((x) => x)));
}
