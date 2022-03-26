import 'package:uuid/uuid.dart';

class UuidService {
  final Uuid _uuid = Uuid();

  String generateId() => _uuid.v1();
}
